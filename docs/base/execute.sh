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