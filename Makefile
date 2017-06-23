CLOUDFORMATION_FILES=cloudformation/infrastructure.yaml \
                     cloudformation/pipeline.yaml \
                     cloudformation/s3-bucket.yaml

validate:
	@echo $(CLOUDFORMATION_FILES) | xargs -n1 -t -I{} \
	aws cloudformation validate-template --template-body file://{}

