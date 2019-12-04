variable "private-subnet01id" {}
variable "private-subnet02id" {}

# ElasciCache サブネットグループ
resource "aws_elasticache_subnet_group" "elasticache-subnet-group" {
  name = "elasticache-subnet-group"
  subnet_ids = ["${var.private-subnet01id}", "${var.private-subnet02id}"]
}

# ElastiCache レプリケーショングループ
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "redis-cluster"
  replication_group_description = "redis description"
  node_type                     = "cache.t2.micro"
  number_cache_clusters         = 2
  port                          = 6379
  parameter_group_name          = "default.redis5.0"
  availability_zones            = ["ap-northeast-1a", "ap-northeast-1c"]
  automatic_failover_enabled    = true
}
