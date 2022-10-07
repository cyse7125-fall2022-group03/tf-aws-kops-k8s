# tf-aws-kops-k8s
This repository is for KOPS (Kubernetes Operations) on AWS.

| Name                | NUID      | Email                           |
| ------------------- | --------- | ------------------------------- |
| Ketki Kule          | 001549838 | kule.k@northeastern.edu         |
| Sandeep Wagh        | 001839964 | wagh.sn@northeastern.edu        |
| Vignesh Gunasekaran | 001029530 | gunasekaran.v@northeastern.edu  |

## Requirements and Steps

Choose the desired AWS profile by following command
```
export AWS_PROFILE=root
```

Create a ssh key file and add it using command
```
ssh-keygen -f ~/.ssh/kops-key	
ssh-add ~/.ssh/kops-key
```

### Steps to run terraform 

Run the following command to run initialize terraform files
```
terraform init
```

Run the following command to verify the terraform plan
```
terraform plan
```

Run the following command to run the terraform file for creating resources
```
terraform apply
```
### Steps to Create Kubernetes cluster

From the output, configure an aws profile "kops" using command
```
aws configure --profile kops
```

Add below environment variables that is required to create clusters
```
export KOPS_STATE_STORE="s3://xxx-csye7125-team3/"  (unique bucket name)
export MASTER_SIZE="t3.small"
export NODE_SIZE="t3.small"
export ZONES="us-east-1a,us-east-1b,us-east-1c"
export NAME="yyy"   (domain name)
```

Switch to kops AWS profile
```
export AWS_PROFILE=kops
```

Create Kubernetes cluster using the following command
```
kops create cluster --name=${NAME} --cloud=aws --master-zones=${ZONES} --zones=${ZONES} --node-count=3 --topology=private --networking=calico --node-size=${NODE_SIZE} --kubernetes-version=1.22.15 --master-size=${MASTER_SIZE} --master-image=ami-08c40ec9ead489470 --node-image=ami-08c40ec9ead489470 --ssh-public-key=/Users/zzz/.ssh/kops-key.pub --bastion=true --yes
```
Cluster name and domain name are the same

Update the Kubernetes cluster using command
```
kops update cluster ${NAME} --yes
```

Validate the Kubernetes cluster using command
```
kops validate cluster --wait 5m
```
Once the validation is successful with the message 'Your cluster yyy is ready', its time to ssh into bastion host and the private network hosts from that bastion host.

To ssh into bastion host, follow below command
```
ssh -A  ubuntu@abc
where abc is the bastion load balancer's 'DNS name'
```

Now we would have entered into the bastion host.
To ssh into a private host from bastion host, follow below command
```
ssh -A  ubuntu@def
where def is the ip address of one of the private network instances
```
Now we would have entered into that private host.

to exit from these hosts
```
exit
exit
```

Now delete the Kubernetes cluster using command
```
kops delete cluster ${NAME} --yes
```

General:
kops version
kubectl version --output=json
ssh-add -l

