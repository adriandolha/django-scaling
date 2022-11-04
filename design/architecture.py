from diagrams import Cluster, Diagram, Edge
from diagrams.aws.network import Route53, ALB
from diagrams.aws.compute import ECS


def django_scaling_app_ecs_cluster(name, dns):
    with Cluster(name):
        alb = ALB('ALB')
        with Cluster("Django App (ECS)"):
            containers_ = [ECS('task-1'),
                           ECS('task-2'),
                           ECS('task-n')]
            alb >> containers_
        dns >> alb


with Diagram("Django Scaling", show=True, filename='architecture', direction='TB'):
    dns = Route53('http://django.scaling.adolha.com')
    django_scaling_app_ecs_cluster("ECS Region 1 (n=7)", dns)
    django_scaling_app_ecs_cluster("ECS Region 2 (n=7)", dns)
    with Cluster("Region 3") as ecs_region2:
        ecs_master = ECS('locust-master')
        with Cluster("Locust Workers (n=10)"):
            containers = [ECS('locust-worker-1'),
                          ECS('locust-worker-2'),
                          ECS('locust-worker-n')]
        containers >> dns
        ecs_master - containers
