resource "aws_rds_cluster_parameter_group" "cluster_pg-s" {
  name   = "udacity-pg-s"
  family = "aurora-mysql8.0" # Update this line

  parameter {
    name         = "binlog_format"
    value        = "MIXED"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "log_bin_trust_function_creators"
    value        = 1
    apply_method = "pending-reboot"
  }
}

resource "aws_db_subnet_group" "udacity_db_subnet_group" {
  name       = "udacity_db_subnet_group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_rds_cluster" "udacity_cluster-s" {
  cluster_identifier              = "udacity-db-cluster-s"
  availability_zones              = ["us-west-1b", "us-west-1c"]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster_pg-s.name
  vpc_security_group_ids          = [aws_security_group.db_sg_2.id]
  db_subnet_group_name            = aws_db_subnet_group.udacity_db_subnet_group.name
  engine                          = "aurora-mysql" # Add this line
  engine_mode                     = "provisioned"
  engine_version                  = "8.0.mysql_aurora.3.08.0" # Update this line
  skip_final_snapshot             = true
  storage_encrypted               = false
  depends_on                      = [aws_rds_cluster_parameter_group.cluster_pg-s]
  global_cluster_identifier       = "udacity-global-cluster"

  # master_username                 = "udacity"
  # master_password                 = "MyUdacityPassword"

  lifecycle {
    ignore_changes = [
      availability_zones,
      deletion_protection,
      tags,
    ]
  }
}

resource "aws_rds_cluster_instance" "udacity_instance-s" {
  count                = 1
  identifier           = "udacity-db-instance-${count.index}-s"
  cluster_identifier   = aws_rds_cluster.udacity_cluster-s.id
  instance_class       = "db.r5.large" # Update this line
  db_subnet_group_name = aws_db_subnet_group.udacity_db_subnet_group.name
  engine               = "aurora-mysql" # Add this line
}

resource "aws_security_group" "db_sg_2" {
  name   = "udacity-db-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    protocol    = "TCP"
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    protocol    = "TCP"
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }
}
