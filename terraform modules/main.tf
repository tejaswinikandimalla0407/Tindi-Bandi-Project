provider "aws" {
    region = var.region
}
module "networking" {
  source              = "./modules/network"
  region              = var.region
  azs                 = var.azs
  vpc_cidr            = var.vpc_cidr
  name_prefix         = var.name_prefix
  enable_dns          = var.enable_dns
  enable_public_ip    = var.enable_public_ip
}

module "ekc" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  node_desired_size = var.node_desired_size
  public_subnet_ids = module.networking.public_subnet_ids
  node_min_size = var.node_min_size
  node_max_size = var.node_max_size
  instance_type = var.instance_type
}
module "bastionhost" {
  source = "./modules/bastionhost"
  vpc_id = module.networking.vpc_id
  instance_type = var.instance_type
  ami_id = var.ami_id
  public_subnet_ids = module.networking.public_subnet_ids
  key_name = var.key_name
}
module "jenkins"{
  source = "./modules/jenkins"
  ami_id = var.ami_id
  instance_type = var.instance_type
  vpc_id = module.networking.vpc_id
  key_name = var.key_name
  public_subnet_ids = module.networking.public_subnet_ids
}
module "sonar"{
  source = "./modules/sonarqube"
  ami_id = var.ami_id
  instance_type = var.instance_type
  vpc_id = module.networking.vpc_id
  key_name = var.key_name
  public_subnet_ids = module.networking.public_subnet_ids
}
module "ecr" {
  source = "./modules/ecr"
}