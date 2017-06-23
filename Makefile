CLOUDFORMATION_FILES=cloudformation/infrastructure.yaml \
                     cloudformation/pipeline.yaml \
                     cloudformation/s3-bucket.yaml

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
