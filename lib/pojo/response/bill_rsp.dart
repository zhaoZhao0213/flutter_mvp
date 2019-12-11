

class BillRsp {
    String actualTotal;
    List<BillDetails> list;
    int orderCount;
    String receivableTotal;
    String refundTotal;

    BillRsp({this.actualTotal, this.list, this.orderCount, this.receivableTotal, this.refundTotal});

    factory BillRsp.fromJson(Map<String, dynamic> json) {
        return BillRsp(
            actualTotal: json['actualTotal'],
            list: json['list'] != null ? (json['list'] as List).map((i) => BillDetails.fromJson(i)).toList() : null,
            orderCount: json['orderCount'],
            receivableTotal: json['receivableTotal'],
            refundTotal: json['refundTotal'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['actualTotal'] = this.actualTotal;
        data['orderCount'] = this.orderCount;
        data['receivableTotal'] = this.receivableTotal;
        data['refundTotal'] = this.refundTotal;
        if (this.list != null) {
            data['list'] = this.list.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class BillDetails {
    String createtime;
    String out_trade_no;
    String service;
    String status;
    String total_fee;

    BillDetails({this.createtime, this.out_trade_no, this.service, this.status, this.total_fee});

    factory BillDetails.fromJson(Map<String, dynamic> json) {
        return BillDetails(
            createtime: json['createtime'],
            out_trade_no: json['out_trade_no'],
            service: json['service'],
            status: json['status'],
            total_fee: json['total_fee'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['createtime'] = this.createtime;
        data['out_trade_no'] = this.out_trade_no;
        data['service'] = this.service;
        data['status'] = this.status;
        data['total_fee'] = this.total_fee;
        return data;
    }
}