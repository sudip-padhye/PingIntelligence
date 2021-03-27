sudo apt-get update &&
pip3 install python-openstackclient &&
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - &&
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" &&
sudo apt-get update && sudo apt-get install terraform &&
export CLUSTER=pingintelligence &&
cd inventory/kubejetstream &&
bash terraform_init.sh &&
bash terraform_apply.sh &&
export IP=149.165.156.145 &&
cd ../../ &&
pip install -r requirements.txt &&
eval $(ssh-agent -s) &&
ssh-add ~/.ssh/id_rsa &&
ansible -i inventory/kubejetstream/hosts -m ping all &&
bash k8s_install.sh &&
ssh ubuntu@$IP &&
sudo su &&
git clone https://github.com/airavata-courses/PingIntelligence.git &&
cd PingIntelligence &&
git checkout kubernetes_files &&
kubectl apply -f ../PingIntelligence/ &&
kubectl get pods
