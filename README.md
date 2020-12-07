# ft_services

## Requirement

## Usage

## Commands
## shell
```sh
export -p
```

## minikube
```sh
minikube addons list
minikube dashboard
```

# References
## Container
### Telegraf
- Telegrafとは，2015/06/19 に発表された InfluxDB 専用の Go 言語で書かれたメトリクスコレクタ(エージェント)で，fluentd などの中間層をはさまず，InfluxDB に最適化されたデータ格納をしてくれるエージェントのこと．
- [influxdata/telegraf](https://github.com/influxdata/telegraf)
- https://www.influxdata.com/time-series-platform/telegraf/

### Alpine
- Alipine とは，組み込み系でよく使われている BusyBox と musl をベースにした Linux ディストリビューションのこと．
- https://pkgs.alpinelinux.org/packages
- [Alpine Linux の Edge とか Testing とは何なのか](https://qiita.com/Mister_K/items/1c03b5f794d051d1d82d)

## Nginx
- [nginx を docker で動かすときの Tips 3選 (foreground で起動する)](https://heartbeats.jp/hbblog/2014/07/3-tips-for-nginx-on-docker.html)

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
