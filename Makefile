CLOUDFORMATION_FILES=cloudformation/infrastructure.yaml \
                     cloudformation/pipeline.yaml \
                     cloudformation/s3-bucket.yaml

GitHubUser=$(shell git remote -v | grep github | head -n1 | cut -d ':' -f2 | cut -d '/' -f1)
GitHubRepository=$(shell git remote -v | grep github | head -n1 | cut -d ':' -f2 | cut -d '/' -f2 | cut -d '.' -f1)
ArtifactS3Bucket=${GitHubUser}-${GitHubRepository}-artifacts
AWS_PROFILE=--profile priv-admin

validate:
	@echo $(CLOUDFORMATION_FILES) | xargs -n1 -t -I{} \
	aws cloudformation validate-template --template-body file://{}

create-artifact-bucket:
	aws cloudformation create-stack \
		--stack-name ${ArtifactS3Bucket} \
		--template-body file://cloudformation/s3-bucket.yaml ${AWS_OPTS} \
		--parameters \
 	    	"ParameterKey=BucketName,ParameterValue=${ArtifactS3Bucket}" \
 	   ${AWS_PROFILE}

%-stack:
	aws cloudformation $@ --capabilities  CAPABILITY_NAMED_IAM \
 	   --stack-name ${GitHubRepository} \
 	   --template-body file://cloudformation/pipeline.yaml \
 	   --parameters \
 	   		"ParameterKey=ApplicationName,ParameterValue=${GitHubRepository}" \
 	    	"ParameterKey=GitHubUser,ParameterValue=${GitHubUser}" \
 	    	"ParameterKey=ArtifactS3Bucket,ParameterValue=${ArtifactS3Bucket}" \
 	    	"ParameterKey=GitHubOAuthToken,ParameterValue=${GitHubOAuthToken}" \
 	    	"ParameterKey=GitHubRepository,ParameterValue=${GitHubRepository}" \
 	   ${AWS_PROFILE}

delete-stack:
	aws cloudformation delete-stack --stack-name ${GitHubRepository} ${AWS_PROFILE}
