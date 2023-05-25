function kubeenv;
    argparse --ignore-unknown 'n/no-proxy' 'c/context=+' -- $argv
    set kube_verbs       get describe delete edit
    set kube_verbs_short g   d        rm     e
    
    set kube_resource       pods deployments services ingresses configmaps daemonsets statefulsets namespace namespace
    set kube_resource_short p    d           s        i         c          ds         ss           n         ns

    for verb_index in (seq (count $kube_verbs))
        abbr "k$kube_verbs_short[$verb_index]" "kubectl $kube_verbs[$verb_index]"
        for res_index in (seq (count $kube_resource))
            abbr "k$kube_verbs_short[$verb_index]$kube_resource_short[$res_index]" "kubectl $kube_verbs[$verb_index] $kube_resource[$res_index]"
        end
    end

    abbr k kubectl
    abbr kl kubectl logs -f
    abbr kgl kubectl logs -f
    abbr kaf kubectl apply -f
    abbr kr kubectl rollout
    abbr krs kubectl rollout status
    abbr krr kubectl rollout restart
    abbr kt kubectl top
    abbr ktp kubectl top pods
    abbr ktn kubectl top nodes
    abbr kpf kubectl port-forward
    abbr kfp kubectl port-forward
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

