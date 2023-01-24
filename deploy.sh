#!/bin/sh

echo "Pre-Build Steps:"
echo "authenticating with AWS ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 637071970882.dkr.ecr.us-east-1.amazonaws.com

echo "Build Steps:"
echo "building image..."
docker build -t 637071970882.dkr.ecr.us-east-1.amazonaws.com/react-docker-aws:latest .

echo "Post-Build Steps:"
echo "pushing image to AWS ECR..."

docker push 637071970882.dkr.ecr.us-east-1.amazonaws.com/react-docker-aws:latest

echo "Updating AWS ECS Service..."
aws ecs update-service --cluster react-cluster --service react-sv --force-new-deployment

echo "Done!"