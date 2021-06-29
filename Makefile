NAME=pipes-ml-api
COMMIT_ID=$(shell git rev-parse HEAD)


build-ml-api-heroku:
	docker build --build-arg PIP_EXTRA_INDEX_URL=${PIP_EXTRA_INDEX_URL} -t registry.heroku.com/$(NAME)/web .
 
push-ml-api-heroku:
	docker push registry.heroku.com/${HEROKU_APP_NAME}/web:latest

# build-compose-ml-api-heroku:
# 	docker-compose -f packages/ml_api/docker/docker-compose.yml build --build-arg PIP_EXTRA_INDEX_URL=${PIP_EXTRA_INDEX_URL} NAME=${NAME}
 
# push-compose-ml-api-heroku:
# 	docker-compose push registry.heroku.com/${HEROKU_APP_NAME}/web:latest

aws-setup:
	aws configure set aws_access_key_id ${AWS_ACCESS_KEY}
	aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
	aws configure set default.region ${AWS_DEFAULT_REGION}

build-ml-api-aws:
	docker build --build-arg PIP_EXTRA_INDEX_URL=${PIP_EXTRA_INDEX_URL} -t $(AWS_ECR_REPO_NAME):$(COMMIT_ID) .

tag-ml-api:
	docker tag $(AWS_ECR_REPO_NAME):$(COMMIT_ID) ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/$(AWS_ECR_REPO_NAME):$(COMMIT_ID)

push-ml-api-aws:
	docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/$(AWS_ECR_REPO_NAME):$(COMMIT_ID)



