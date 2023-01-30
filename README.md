# 避免网络不通导致依赖包无法安装的镜像构建方法
<p>
  <img src="https://github.com/tornado404/muti_arch_image_build/blob/master/demo.gif?raw=true" width="500" />
  
</p>

## 简介
镜像构建现状：

- 404Not found、从`apt-get update`到`docker pull`、`github`访问不通等多重问题困扰，原本轻易能实现的镜像构建变成了一天以上的工作量；
- 换个思路，可以去vlutr网站购买一台海外服务器实例，构建完镜像并推送到dockerhub，就销毁，这种方式的金钱消耗<0.5元/次，耗时将缩短至服务器的购买时间5min+创建时间15min（没错，创建到真正能ssh登录耗时约15min）

`muti_arch_image_build`功能概括：

- 镜像构建无障碍，利用GitHub服务器的网络能力进行镜像构建,流畅安装各种包，并推送到dockerhub
- 构建流程全程透明可见，无需担心隐私信息泄露
- 单次构建耗时低于10min
- 镜像构建使用github服务器,镜像存储使用dockerhub,0成本

解决了什么问题：

1. 国内网络问题，DNS不通，大量依赖包需要配置国内源才能下载安装
2. 全程免费

适用场景:
- 因不可抗力导致镜像构建困难,大量包无法下载
- 镜像里不存储你的银行卡密码

注意：我想没有人会将敏感信息打到镜像里



## 1. 工具实现

```
1、 读取环境变量，包括tag值、docker信息、github信息
2、 安装github client
3、 拉取自己的repo库 xxx，默认值为muti_arch_image_build
4、 更新镜像构建信息，并推送到github自动执行镜像构建流水线
5、 执行成功后到dockerhub确认最新镜像已推送成功
```



### Dockerfile
zzc932/githubcli:latest
```
FROM ubuntu:18.04
#RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list && rm -Rf /var/lib/apt/lists/* && apt-get update

RUN type -p curl >/dev/null ||  apt install curl -y \
&& curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |  dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&&  chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |  tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&&  apt update \
&&  apt install -y gh vim curl wget 

WORKDIR /build
ADD execute.sh /build
```





### 容器内执行的脚本内容




```
# 配置token
cat>/tmp/token.txt<<EOF
$github_token
EOF
# login your github repo
gh auth login --with-token < /tmp/token.txt
gh repo view $github_account/$image_repo
# 下载代码库
# download repo
mkdir /repo && cd /repo
gh repo clone $github_account/$image_repo && cd $image_repo
# 设置docker仓库地址
gh secret set DOCKERHUB_TOKEN --body $dockerhub_password  --repos $github_account/$image_repo
gh secret set DOCKERHUB_USERNAME  --body $dockerhub_username --repos $github_account/$image_repo
# 更新dockerfiles

# 更新.github目录下的workflows
export tag="IMAGE_WITH_TAG: $tag"
cat>/tmp/replace_image_tag.sh<<EOF
sed -i 's@IMAGE_WITH_TAG:.*\$@$tag@g' /repo/$image_repo/.github/workflows/test.yml
EOF
bash /tmp/replace_image_tag.sh

cp /tmp/Dockerfile  /repo/$image_repo/dockerfiles

git config user.name $github_account
git config user.email $github_email
gh auth setup-git
git add /repo/$image_repo/.github/workflows/test.yml && git add . && git commit -m "update image" && git push
```

## 2. 使用
### 初始化信息

#### 配置github、docker、镜像信息

```
build_dir=/tmp/ci
mkdir $build_dir
cat>$build_dir/envs.list<<EOF
github_account=your_account
github_email=wahaha@tornado.com
image_repo=muti_arch_image_build
github_token=your_github_token
dockerhub_password=your_docker_password
dockerhub_username=your_docker_username
tag="wahaha/test:1"
EOF
```

| 字段名             | 字段说明                                                     |
| ------------------ | ------------------------------------------------------------ |
| github_account     | 访问https://github.com/，点击右上角头像，可以看到Signed in as xxx，那个就是你的账号 |
| github_email       | 随便填写一个，用于提交代码时的邮箱信息                       |
| image_repo         | 构建镜像所用的代码库，请从[这里](https://github.com/tornado404/muti_arch_image_build) fork到自己的账户下 |
| github_token       | [Developer settings](https://github.com/settings/tokens) 下的Personal access tokens，点击”New personal access token“，需勾选以下权限：`repo、project、workflow` ，生成的token注意要保管好 |
| dockerhub_username | docker账号的用户名                                           |
| dockerhub_password | docker账号密码                                               |
| tag                | 待构建的镜像名，注意需加上`dockerhub_username`作为前缀       |
| build_dir          | 以上信息配置文件和dockerfile文件的路径                       |



#### 准备要构建的dockerfile

请拷贝Dockerfile到$build_dir路径下，或执行以下命令创建一个新的Dockerfile内容

```
cat>$build_dir/Dockerfile<<EOF
FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y libfuse-dev fuse gcc automake autoconf libtool make tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
EOF
```

### 执行构建

```
docker run --rm --env tag=zzc932/autodemo:1 --env-file $build_dir/envs.list -v $build_dir:/tmp --rm -it zzc932/githubcli:latest bash /build/execute.sh
```


