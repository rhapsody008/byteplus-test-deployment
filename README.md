# byteplus-test-deployment
test Byteplus

## Test Arch Design
### Senario
- K8s cluster and other resources seamlessly setup in byteplus account
- Application deployed successfully in VKE
- Application upload file to Torch object storage

### Components
Public subnet - Route table set to IGW with public ip, ALB/CLB
Private subnet - VKE w/ k8s app, Database

### Manual Steps
- [ ] create Byteplus account
- [ ] Setup basic IAM credentials w/ provisioner access & store information in a parameter store

### Terraform Structure
- Backend managed by TOS
- infra folder w/ VPC, Public/private Subnets, Route tables, IGW, security groups, ACLs(If Any)
- resources folder w/ IAM instance role, Load Balancer, VKE cluster, Database, ToS
- app folder w/ possible auth setup, namespace, app deployment, service exposure, ingress (if any, explore loadbalancer)

- Deployment sequence: infra -> resources -> app

## Actions
- Account created
- Power user (provisioner) created
{"Account ID":3000501014,"Username":"provisioner","Password":"Vickyd1010","Access key":"AKAPZjBmYjIzYmIxODhjNGIwZWI3MDVjMmY5OTBmYmYwNTE","Secret access key":"T0RCaVlUUTJabVZpTjJVNE5EVmpaVGszTldZek9UZGhPVEF3T0RRell6UQ=="}

## Feedback


### Console & Manual steps
- Organization name is mandatory - personal users?
- A mixture of Chinese and English (account setup in Chinese)
- No place to manage/protect secret


### Terraform
- no doc about remote backend configuration

### Others
- no Byteplus CLI?