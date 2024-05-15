## EKS Ingress & ALB 整合

### [安裝 AWS Load Balancer Controller 附加元件-官方文件](https://docs.aws.amazon.com/zh_tw/eks/latest/userguide/aws-load-balancer-controller.html)
- 簡要說明如下
1. 建立 IAM Policy(政策)，名稱可以直接使用官方建議 `AWSLoadBalancerControllerIAMPolicy`，首先要確定你的資源在哪一個 AWS Region，因為 Policy 內會決定了未來 Ingress 能夠掛載的 ACM 憑證是哪一個區域
 
2. 建立 IMA Role(腳色)，名稱可以直接使用官方建議`AmazonEKSLoadBalancerControllerRole`，並且將 `AWSLoadBalancerControllerIAMPolicy` 賦予這個角色，直接用底下指令

先執行這行可才能Create IAM
```bash=
eksctl utils associate-iam-oidc-provider --region=ap-southeast-1 --cluster=ailab-yashbet-dev --approve
```

```bash=
eksctl create iamserviceaccount --cluster=ailab-yashbet-dev --namespace=kube-system --name=aws-load-balancer-controller --role-name AmazonEKSLoadBalancerControllerRole_DEV --attach-policy-arn=arn:aws:iam::420163908753:policy/AWSLoadBalancerControllerIAMPolicy --approve
```

> 上面指令的意思就是使用 AWS 的 IAM 整合到 EKS 的 ServiceAcconut，會在 K8S Cluster 部屬一個 ServiceAcconut 的物件，名稱為 aws-load-balancer-controller，並且建立在 kube-system 這個命名間底下


3. 安裝 `aws-load-balancer-controller`，直接使用 helm 指令，請確保已經預先裝好 helm cli 工具
  - 先將 helm repo 位置加入 `helm repo add eks https://aws.github.io/eks-charts`
  - 更新 helm repo `helm repo update eks`
  - 安裝 `helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=ailab-yashbet-dev --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller --set region=ap-southeast-1 --set vpcId=vpc-03f96b97696e067b6`

> 上面指令的意思就是，使用 helm 部屬一個 Deployment 物件，名稱叫做 aws-load-balancer-controller，並且建立在 kube-system 這個命名間底下，然後部屬這個 Deployment 使用的角色權限是剛剛步驟二建立的 ServiceAcconut，同時指定 VPCId、跟 AWS Region