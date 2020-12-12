# Service
- Service は多くの場合，Pod へのアクセスを抽象化するオブジェクトのことだが，他の種類のバックエンドも抽象化できる．
- 端的には Selector で選択した Pod を Upstream としたLB．
- Service には4つの種類がある．
	- ClusterIP
	- NodePort
	- LoadBalancer
	- ExternalName

## ClusterIP
- クラスター内部の IP で Service を公開する．
- このタイプでは Service はクラスター内部からのみ疎通性があります．
- このタイプはデフォルトの ServiceType です．

## NodePort
- 各 Node の IP にて，静的なポート(NodePort)上でServiceを公開する．
- その NodePort の Service が転送する先の ClusterIP Service が自動的に作成されます。
- <NodeIP>:<NodePort> にアクセスすることによって NodePort Service にアクセスできるようになる．

## LoadBalancer
- クラウドプロバイダーのロードバランサーを使用して，Service を外部に公開する．
- クラスター外部にあるロードバランサーが転送する先の NodePort と ClusterIP Service は自動的に作成される．

## ExternalName
- CNAME レコードを返すことにより，externalName フィールドに指定したコンテンツ(例: foo.bar.example.com)と Service を紐づける．
- しかし，いかなる種類のプロキシーも設定されない．

## References
- https://kubernetes.io/ja/docs/concepts/services-networking/service/
