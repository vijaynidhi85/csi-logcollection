#/bin/bash
set -x
set -o errexit

kubectl get pods -n ntnx-system csi-provisioner-ntnx-plugin-0 -o yaml > csi_ntnx_plugin_pod_spec.yaml
kubectl get sc -o yaml > sc.yaml
kubectl get pods -A -o wide > all_pods.txt
kubectl describe pods -A > all_pods_describe.txt
kubectl describe pvc -A > all_pvc_describe.txt
kubectl describe pv -A > all_pv_describe.txt
kubectl get events -A  > all_events.txt
kubectl logs -n ntnx-system csi-provisioner-ntnx-plugin-0 -c ntnx-csi-plugin > ntnx-csi-plugin.log
kubectl logs -n ntnx-system csi-provisioner-ntnx-plugin-0 -c csi-resizer > ntnx-csi-resizer.log
kubectl logs -n ntnx-system csi-provisioner-ntnx-plugin-0 -c csi-provisioner > csi-provisioner.log
kubectl logs -n ntnx-system csi-provisioner-ntnx-plugin-0 -c csi-attacher > csi-attacher.log
kubectl logs -n ntnx-system csi-provisioner-ntnx-plugin-0 -c csi-attacher > csi-snapshotter.log
kubectl logs -n ntnx-system csi-provisioner-ntnx-plugin-0 -c csi-attacher > csi-external-health-monitor-controller.log
for i in `kubectl get pods -n ntnx-system -l app=csi-node-ntnx-plugin -ojsonpath='{.items[*].metadata.name}'`;do kubectl logs -n ntnx-system $i -c csi-node-ntnx-plugin > csi-node-ntnx-plugin_$i.log;done
for i in `kubectl get pods -n ntnx-system -l app=csi-node-ntnx-plugin -ojsonpath='{.items[*].metadata.name}'`;do kubectl logs -n ntnx-system $i -c driver-registrar > driver-registrar_$i.log;done


