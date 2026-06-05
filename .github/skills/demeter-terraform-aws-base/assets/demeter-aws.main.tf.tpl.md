module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.environment_name
  cidr = var.vpc_cidr

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false

  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true

  tags = {
    Environment = var.environment_name
    ManagedBy   = "Gaia-Demeter"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = var.environment_name
  cluster_version = "1.27"

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_public_access_cidrs = ["10.0.0.0/8"]

  eks_managed_node_groups = {
    initial = {
      instance_types = ["m5.large"]
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.0.0"

  identifier = "rds-postgres-main"

  engine               = "postgres"
  engine_version       = "14"
  instance_class       = "db.t4g.large"

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = "applicationdb"
  username = "dbadmin"
  port     = 5432

  multi_az               = true
  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.vpc.default_security_group_id]

  storage_encrypted = true
  kms_key_id        = var.kms_key_arn

  backup_retention_period = 7
  skip_final_snapshot     = true
}
