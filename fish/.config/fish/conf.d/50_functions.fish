function kubeenv;
    argparse --ignore-unknown 'n/no-proxy' 'c/context=+' -- $argv

    abbr k kubectl
    abbr kg kubectl get
    abbr kgp kubectl get pods
    abbr kgd kubectl get deployments
    abbr kgs kubectl get services
    abbr kd kubectl describe
    abbr kdp kubectl describe pods
    abbr kdd kubectl describe deployments
    abbr kds kubectl describe services
    abbr kl kubectl logs -f
    abbr ka kubectl apply
    abbr kaf kubectl apply -f
    abbr kr kubectl rollout
    abbr krs kubectl rollout status
    abbr krr kubectl rollout restart
    abbr krm kubectl delete
    set -g theme_display_k8s_context yes

    if not set -q _flag_no_proxy 
        set -xg http_proxy http://bastion:3128/
        set -xg https_proxy http://bastion:3128/
        set -xg HTTP_PROXY http://bastion:3128/
        set -xg HTTPS_PROXY http://bastion:3128/
    end

    alias kns "kubectl config view --minify --output 'jsonpath={..namespace}'"
    abbr ksns "kubectl config set-context --current --namespace"

    function kexec;
        argparse --ignore-unknown 'n/namespace=+' 'p/pod=+' -- $argv
        set --query _flag_namespace; or set --local _flag_namespace (kubectl config view --minify --output 'jsonpath={..namespace}')
        set --query _flag_pod; or set --local _flag_pod shop
        set --local POD (kubectl get pods --namespace $_flag_namespace | grep "^$_flag_pod" | grep Running | head -n1 | awk '{ print $1 }')
        kubectl exec --namespace $_flag_namespace -it $POD -- $argv
    end

    abbr kmanage "kexec python3 /src/lib/manage.py"
    alias kpsql "ssh bastion -q -C 'psql -hdb01 -Ubilligvvs_dk billigvvs_dk'"
end

