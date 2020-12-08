# ft_services

## Requirement

## Usage

## Commands
## shell
```sh
export -p
```

## docker
```sh
docker run -it --rm -p 80:80 -p 443:443 -p 22:22 my_nginx sh
```

## kubectl
```sh
# 全ての namespace の pod の一覧を表示
kubectl get pods --all-namespaces
# 現在動いている pod の一覧を表示
kubectl get pods
# 指定した pod の情報を表示
kubectl get pods -l app=nginx
# 指定した pod の詳しい情報を表示
kubectl describe pod nginx
# pod 削除
kubectl delete -f srcs/nginx/nginx.yaml
kubectl delete deployment nginx
# pod 追加
kubectl apply -f srcs/nginx/nginx.yaml
```

## minikube
```sh
# addon の list 表示
minikube addons list
# dashboard 起動
minikube dashboard
```

## SSL
```sh
# 証明書内容の確認 in nginx
openssl s_client -connect localhost:443 -showcerts
```

## SSH
```sh
# sshd の daemon 起動
/usr/sbin/sshd
# sshd の daemon 終了
kill `cat /var/run/sshd.pid'
```

# References
## k8s yaml 関連
- [Deploymentを使用してステートレスアプリケーションを実行する](https://kubernetes.io/ja/docs/tasks/run-application/run-stateless-application-deployment/)
- `---` は複数のマニフェストを1つのファイルに書くためのセパレーター．
- [Kubernetesの4つのリソース - Pod/ReplicaSet/Deployment/Service](https://news.mynavi.jp/itsearch/article/devsoft/4358)
- [Deployment](https://kubernetes.io/ja/docs/concepts/workloads/controllers/deployment/)
- [LabelとAnnotation, Service->Deployment](https://tomokazu-kozuma.com/on-the-distinction-between-label-and-annotation-of-kubernetes/)
- [マニフェストファイルで使われるLabelとSelectorについて](https://gadgeterkun.hatenablog.com/entry/20190716/1563228000)
- [【Kubernetes】5種類のServiceタイプを解説する](https://ameblo.jp/bakery-diary/entry-12614040050.html)
- [Serviceの定義](https://kubernetes.io/ja/docs/concepts/services-networking/service/#serviceの定義)
- [Kubernetesの apiVersion に何を書けばいいか](https://qiita.com/soymsk/items/69aeaa7945fe1f875822)

## Container
### Telegraf
- Telegrafとは，2015/06/19 に発表された InfluxDB 専用の Go 言語で書かれたメトリクスコレクタ(エージェント)で，fluentd などの中間層をはさまず，InfluxDB に最適化されたデータ格納をしてくれるエージェントのこと．
- [influxdata/telegraf](https://github.com/influxdata/telegraf)
- https://www.influxdata.com/time-series-platform/telegraf/
- [influxdata/influxdata-docker/telegraf/1.16/alpine/Dockerfile](https://github.com/influxdata/influxdata-docker/blob/da900619b14ddbf221e639b5108a7219af8b0bbc/telegraf/1.16/alpine/Dockerfile)

### Alpine
- Alipine とは，組み込み系でよく使われている BusyBox と musl をベースにした Linux ディストリビューションのこと．
- https://pkgs.alpinelinux.org/packages
- [Alpine Linux の Edge とか Testing とは何なのか](https://qiita.com/Mister_K/items/1c03b5f794d051d1d82d)

## Nginx
- [nginx を docker で動かすときの Tips 3選 (foreground で起動する)](https://heartbeats.jp/hbblog/2014/07/3-tips-for-nginx-on-docker.html)
- [can't run nginx in alpine linux (docker)](https://superuser.com/questions/1306656/cant-run-nginx-in-alpine-linux-docker)
- [Alpine Nginx with PHP](https://wiki.alpinelinux.org/wiki/Nginx_with_PHP)

## SSL
- [opensslコマンドでcsrファイルを作成する際のサーバ名等をコマンドラインオプションで指定する](https://vogel.at.webry.info/201503/article_9.html)
- [opensslコマンドで証明書情報を確認したい](https://jp.globalsign.com/support/faq/07.html)
- [〔パスワード認証：rootログイン許可〕](http://bluearth.cocolog-nifty.com/blog/2018/08/root-7716.html)

## k8s 関連
### MetalLB
- MetalLB とは，Google が作ったベアメタル Kubenetes 環境でも使える External Load Balancer のこと．
- [metallb/metallb](https://github.com/metallb/metallb)

#### ロードバランサー
- [ーロードバランサの種類L4,L7ってどう違うの？](https://academy.gmocloud.com/qa/20170810/4591)

### Minikube
- Minikube とは，ローカル環境で Kubernetes を簡単に実行できるツールのこと．
- [Minikubeを使用してローカル環境でKubernetesを動かす](https://kubernetes.io/ja/docs/setup/learning-environment/minikube/)
- [Minikubeのインストール](https://kubernetes.io/ja/docs/tasks/tools/install-minikube/)
- [Minikube Docs](https://minikube.sigs.k8s.io/docs/)
- [kubernetes/minikube](https://github.com/kubernetes/minikube)

### kind
- Kubernetes IN Docker - local clusters for testing Kubernetes
- https://kind.sigs.k8s.io
- [kubernetes-sigs/kind](https://github.com/kubernetes-sigs/kind)

### Kubectl
- Kubectl とは，Kubenetes クラスターを制御できるコマンドラインツールのこと．
- [kubectlチートシート](https://kubernetes.io/ja/docs/reference/kubectl/cheatsheet/)
- [Introduction to Kubectl](https://kubectl.docs.kubernetes.io/guides/introduction/kubectl/)
- [Kubectl Command Reference](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
- [Reference Docs for Kubectl](https://kubectl.docs.kubernetes.io/references/kubectl/)
- [kubernetes/kubectl](https://github.com/kubernetes/kubectl)
- [How to Run Locally Built Docker Images in Kubernetes](https://medium.com/swlh/how-to-run-locally-built-docker-images-in-kubernetes-b28fbc32cc1d)

### Kustomize
- Kustomize とは，Kubernetes の yaml を効率よく運用するのに特化したパッケージングツールのこと．
- [Reference Docs for Kustomize](https://kubectl.docs.kubernetes.io/references/kustomize/)
- [Introduction to Kustomize](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/)
- [kubernetes-sigs/kustomize](https://github.com/kubernetes-sigs/kustomize)

### Kubernetes
- Kubernetes とは，コンテナオーケストレーションシステムのこと．
- コンテナオーケストレーションシステムとは，
	- たくさんのサーバーに，
	- たくさんのコンテナを置いて，
	- 連携させるようなアプリケーションを
	- デプロイ・管理・スケールとかさせるシステムのこと．
- Kubernetes は，2020年現在デファクトスタンダートなコンテナオーケストレーションシステム．
- Kubernetes とは，コンテナの運用管理と自動化を目的に設計されたオープンソースシステムのこと．
- [kubernetes/kubernetes](https://github.com/kubernetes/kubernetes)
- [kubernetes/examples](https://github.com/kubernetes/examples)

### Shellscript
- [初心者向けシェルスクリプトの基本コマンドの紹介](https://qiita.com/zayarwinttun/items/0dae4cb66d8f4bd2a337)
