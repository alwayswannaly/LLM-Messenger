# Grant Image Permission
aws ecr get-login-password --region us-west-2 --profile mit-staging | docker login --username AWS --password-stdin 555073836652.dkr.ecr.us-west-2.amazonaws.com

docker tag 165eea9f1021 555073836652.dkr.ecr.us-west-2.amazonaws.com/llm-messenger:alpha

docker push 555073836652.dkr.ecr.us-west-2.amazonaws.com/llm-messenger:alpha
