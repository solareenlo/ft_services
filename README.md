# ft_services

## Requirement

## Usage

## Commands
## ftps, lftp
```sh
lftp -e 'set ssl:verify-certificate false' -u $USER_HERE,$PASSWORD_HERE -p 21 $IP_HERE
lftp -e 'set ssl:verify-certificate false' -u username,password -p 21 192.168.99.10
curl -k --ftp-ssl --user $USER_HERE:$PASSWORD_HERE ftp://$IP_HERE/
curl -k --ftp-ssl --user username:password ftp://192.168.99.10:21
```

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
kubectl get pods -l app=nginx -o wide
kubectl get pods -l app=nginx -o yaml
# 指定した pod の詳しい情報を表示
kubectl describe pod nginx
# 指定した service の情報を表示
kubectl get svc nginx
# pod 削除
kubectl delete -f srcs/nginx/nginx.yaml
kubectl delete deployment nginx
# pod 追加
kubectl apply -f srcs/nginx/nginx.yaml
# 動いてる pod の中に入る
kubectl exec --stdin --tty nginx-??? -- /bin/sh
kubectl exec -it nginx-??? -- /bin/sh
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
## ftps
- [パッシブモードのFTPS通信のFWの設定](https://www.replystudio.net/2014/10/ftpsfw.html)
- [debian/unstable/manpages-ja/vsftpd.conf(5)](https://manpages.debian.org/unstable/manpages-ja/vsftpd.conf.5.ja.html)
- [man page of VSFTPD.CONF](https://linuxjm.osdn.jp/html/vsftpd/man5/vsftpd.conf.5.html)
- [lavv17/lftp](https://github.com/lavv17/lftp)
	- ftps をコマンドで使うツール．

## コマンド
- [tar の --strip-components と -C オプションを使ってスマートに展開する](https://kakakakakku.hatenablog.com/entry/2018/06/13/220940)
- [|| でコマンドをつなげると、直前のコマンドが失敗した場合のみ次のコマンドが実行される。](https://shellscript.sunone.me/exit_status.html)

## sql
- wordpress の初期起動時に wordpress から mysql へ接続するためには，Database Host の欄に `mysql 名:port number' を入力すべし．
	- 例: `wordpress-mysql:3306`
- [Bind Addressの意味がようやく分かった](https://keens.github.io/blog/2016/02/24/bind_addressnoimigayouyakuwakatta/)

## Dockerfile 関連
## ftps
- [delfer/docker-alpine-ftp-server](https://github.com/delfer/docker-alpine-ftp-server)

### phpmyadmin
- [mhzawadi/phpmyadmin](https://github.com/mhzawadi/phpmyadmin)
- [phpmyadmin/docker/fpm-alpine/](https://github.com/phpmyadmin/docker/tree/master/fpm-alpine)

### php/wordpress
- [Editing wp-config.php/wordpress](https://wordpress.org/support/article/editing-wp-config-php/)
- [php extentions/wordpress](https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions)

### php
- [php/7.4/alpine3.12/fpm/Dockerfile](https://github.com/docker-library/php/blob/master/7.4/alpine3.12/fpm/Dockerfile)

### supervisor
- [Dockerでsupervisorを使う時によくハマる点まとめ](https://techracho.bpsinc.jp/morimorihoge/2017_06_05/40936)
- [Superviso: Configuration File](http://supervisord.org/configuration.html)
- [Supervisor: A Process Control System](http://supervisord.org/index.html)

## k8s yaml 関連
### influxdata
- [influxdata/docs-v2/static/downloads/influxdb-k8-minikube.yaml](https://github.com/influxdata/docs-v2/blob/master/static/downloads/influxdb-k8-minikube.yaml)

### general
- [コンテナでプログラムをrootとして実行することがなぜ問題なのか KubernetsのCVE-2019-11245を例に考える](https://unit42.paloaltonetworks.jp/non-root-containers-kubernetes-cve-2019-11245-care/)
- [いい加減覚えよう。 `command > /dev/null 2>&1`の意味](https://qiita.com/ritukiii/items/b3d91e97b71ecd41d4ea)
- [Secrets/kubernetes/docs](https://kubernetes.io/ja/docs/concepts/configuration/secret/)
- [【Kubernetes】Secretとは（概要から生成・編集・利用方法まで）](https://ameblo.jp/bakery-diary/entry-12615574380.html)
- [kubernetesのConfigMapを理解する](https://qiita.com/oguogura/items/68741b91b70962081504)
- [Deploymentを使用してステートレスアプリケーションを実行する](https://kubernetes.io/ja/docs/tasks/run-application/run-stateless-application-deployment/)
- `---` は複数のマニフェストを1つのファイルに書くためのセパレーター．
- [Kubernetesの4つのリソース - Pod/ReplicaSet/Deployment/Service](https://news.mynavi.jp/itsearch/article/devsoft/4358)
- [Deployment](https://kubernetes.io/ja/docs/concepts/workloads/controllers/deployment/)
- [LabelとAnnotation, Service->Deployment](https://tomokazu-kozuma.com/on-the-distinction-between-label-and-annotation-of-kubernetes/)
- [マニフェストファイルで使われるLabelとSelectorについて](https://gadgeterkun.hatenablog.com/entry/20190716/1563228000)
- [【Kubernetes】5種類のServiceタイプを解説する](https://ameblo.jp/bakery-diary/entry-12614040050.html)
- [Serviceの公開 (Serviceのタイプ)](https://kubernetes.io/ja/docs/concepts/services-networking/service/#publishing-services-service-types)
- [Serviceの定義](https://kubernetes.io/ja/docs/concepts/services-networking/service/#serviceの定義)
- [Kubernetesの apiVersion に何を書けばいいか](https://qiita.com/soymsk/items/69aeaa7945fe1f875822)

## Container

## Grafana
- Grafana とは，オープンソースの時系列データを格好良く表示してくれる web アプリケーションのこと．
- [All dashboards >> Docker Dashboard](https://grafana.com/grafana/dashboards/10585)
- [All dashboards >> Telegraf: system dashboard](https://grafana.com/grafana/dashboards/928)
- [Provision dashboards and data sources](https://grafana.com/tutorials/provision-dashboards-and-data-sources/#1)
- [Provisioning Grafana](https://grafana.com/docs/grafana/latest/administration/provisioning/)
- [Using InfluxDB in Grafana](https://grafana.com/docs/grafana/latest/datasources/influxdb/)

### Telegraf
- Telegraf とは，オープンソースな 2015/06/19 に発表された InfluxDB 専用の Go 言語で書かれたメトリクスコレクタ(エージェント)で，fluentd などの中間層をはさまず，InfluxDB に最適化されたデータ格納をしてくれるエージェントのこと．
- [telegraf/plugins/inputs/docker/README.md](https://github.com/influxdata/telegraf/blob/release-1.17/plugins/inputs/docker/README.md)
- [influxdata/telegraf](https://github.com/influxdata/telegraf)
- https://www.influxdata.com/time-series-platform/telegraf/
- [influxdata/influxdata-docker/telegraf/1.16/alpine/Dockerfile](https://github.com/influxdata/influxdata-docker/blob/da900619b14ddbf221e639b5108a7219af8b0bbc/telegraf/1.16/alpine/Dockerfile)

## InfluxDB
- InfluxDB とは，オープンソースな時系列データの扱いに優れた DB のこと．
- [InfluxDB v2.x Output Plugin](https://github.com/influxdata/telegraf/tree/master/plugins/outputs/influxdb_v2)
- [Enable TLS encryption](https://docs.influxdata.com/influxdb/v2.0/security/enable-tls/)
- [InfluxDB configuration options](https://docs.influxdata.com/influxdb/v2.0/reference/config-options/)
- [influxdata | Documentation](https://docs.influxdata.com)

## ftps
- FTPS とは，FTP で送受信するデータを TLS または SSL で暗号化する通信プロトコルのこと．
- [FTPにおけるアクティブモードとパッシブモードの違い](http://cos.linux-dvr.biz/archives/131)
- [FTPS、SFTPの違いって?](https://qiita.com/kasei-san/items/bf766e6c2ececa4c3905)

## phpmyadmin
- phpMyAdmin とは，オープンソースな MySQL サーバをウェブブラウザで管理するためのデータベース接続クライアントツールのこと．
- [Welcome to phpMyAdmin’s documentation!](https://docs.phpmyadmin.net/en/latest/)

### WordPress
- WordPress とは，オープンソースのブログを作るソフトウェアのこと．
- [WordPress Roles and Capabilities](https://wordpress.org/support/article/roles-and-capabilities/)
- [The command line interface for WordPress](https://wp-cli.org/ja/)
- [combro2k/dockerfiles/alpine-nginx-wordpress-php7](https://github.com/combro2k/dockerfiles/tree/master/alpine-nginx-wordpress-php7)
- [etopian/alpine-php-wordpress](https://github.com/etopian/alpine-php-wordpress)
- [TrafeX/docker-wordpress](https://github.com/TrafeX/docker-wordpress)

### Alpine
- Alipine とは，組み込み系でよく使われている BusyBox と musl をベースにした Linux ディストリビューションのこと．
- https://pkgs.alpinelinux.org/packages
- [Alpine Linux の Edge とか Testing とは何なのか](https://qiita.com/Mister_K/items/1c03b5f794d051d1d82d)
- [Alpine LinuxベースでDockerイメージを作るときのapkのコマンドめも](https://tomcky.hatenadiary.jp/entry/2018/02/20/203657)
- [Alpine Linux - Ignoring APKINDEX : Bad file Descriptor](https://unix.stackexchange.com/questions/478182/alpine-linux-ignoring-apkindex-bad-file-descriptor)
- [Alpine Wordpress Php/wiki.alpine](https://wiki.alpinelinux.org/wiki/WordPress#Install_lighttpd.2C_PHP.2C_and_MySql)
- [adduser/wiki.alpine](https://wiki.alpinelinux.org/wiki/Setting_up_a_new_user#adduser)
- [Alpine Linux で ユーザー/グループ を 追加/削除/一覧 する 方法](https://garafu.blogspot.com/2019/07/operate-user-group-on-alpine.html#adduser)

### Alpine で glibc を使う
- [Comparison of C/POSIX standard library implementations for Linux](http://www.etalabs.net/compare_libcs.html)
- [Docker-Hub-frolvlad/docker-alpine-glibc/Dockerfile](https://github.com/Docker-Hub-frolvlad/docker-alpine-glibc/blob/master/Dockerfile)
- [sgerrand/alpine-pkg-glibc](https://github.com/sgerrand/alpine-pkg-glibc)

## Nginx
- [Module ngx_http_proxy_module](http://nginx.org/en/docs/http/ngx_http_proxy_module.html)
- [NGINX Reverse Proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
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
- [Kubernetes NodePort vs LoadBalancer vs Ingress? When should I use what?](https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0)
- [【手順あり】MetalLBの使い方から動きまで解説します](https://blog.framinal.life/entry/2020/04/16/022042#MetalLBの仕組みARPNDPBGP)

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
- [コンテナを使いこなすための心強い味方! 「Kubernetes」(後編)](https://thinkit.co.jp/article/17629)
- [コンテナを使いこなすための心強い味方!「Kubernetes」(中編)](https://thinkit.co.jp/article/17535)
- [コンテナを使いこなすための心強い味方!「Kubernetes」(前編)](https://thinkit.co.jp/article/17453)

### Shellscript
- [初心者向けシェルスクリプトの基本コマンドの紹介](https://qiita.com/zayarwinttun/items/0dae4cb66d8f4bd2a337)
