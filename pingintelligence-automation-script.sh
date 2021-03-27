sudo apt-get update &&
pip3 install python-openstackclient &&
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - &&
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" &&
sudo apt-get update && sudo apt-get install terraform &&
export CLUSTER=pingintelligence &&
mv ./cluster.tfvars jetstream_kubespray/inventory/kubejetstream/ &&
mv ./pingintelligence-automation-script.sh jetstream_kubespray/ &&
cp jetstream_kubespray/inventory/kubejetstream/hosts jetstream_kubespray/inventory/ &&
cd jetstream_kubespray/inventory/kubejetstream &&
bash terraform_init.sh &&
bash terraform_apply.sh &&
export IP=149.165.156.145 &&
cd ../../ &&
sudo apt update &&
sudo apt install python3-pip &&
pip3 --version &&
pip3 install -r requirements.txt &&
eval $(ssh-agent -s) &&
ssh-add ~/.ssh/id_rsa &&
ansible -i inventory/kubejetstream/hosts -m ping all &&
bash k8s_install.sh &&
ssh-keygen -f "~/.ssh/known_hosts" -R "149.165.156.145" &&
ssh ubuntu@$IP &&
sudo su &&
git clone https://github.com/airavata-courses/PingIntelligence.git &&
cd PingIntelligence &&
git checkout kubernetes_files &&
kubectl apply -f ../PingIntelligence/ &&
kubectl get pods