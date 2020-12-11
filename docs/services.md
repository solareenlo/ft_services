# Service
- Service は多くの場合，Pod へのアクセスを抽象化するオブジェクトのことだが，他の種類のバックエンドも抽象化できる．
- 端的には Selector で選択した Pod を Upstream としたLB．
- Service には4つの種類がある．
	- ClusterIP
	- NodePort
	- LoadBalancer
	- ExternalName

## ClusterIP
- クラスター内部の IP で Service を公開する。
- このタイプでは Service はクラスター内部からのみ疎通性があります。
- このタイプはデフォルトの ServiceType です。

## NodePort

## LoadBalancer

## ExternalName

## References
- https://kubernetes.io/ja/docs/concepts/services-networking/service/
