

class CollectionRsp {
    String actualTotal;
    String couponsTotal;
    String membersTotalToday;
    String name;
    String receivableTotal;
    String refundTotal;
    String todayTotal;

    CollectionRsp({this.actualTotal, this.couponsTotal, this.membersTotalToday, this.name, this.receivableTotal, this.refundTotal, this.todayTotal});

    factory CollectionRsp.fromJson(Map<String, dynamic> json) {
        return CollectionRsp(
            actualTotal: json['actualTotal'],
            couponsTotal: json['couponsTotal'],
            membersTotalToday: json['membersTotalToday'],
            name: json['name'],
            receivableTotal: json['receivableTotal'],
            refundTotal: json['refundTotal'],
            todayTotal: json['todayTotal'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['actualTotal'] = this.actualTotal;
        data['couponsTotal'] = this.couponsTotal;
        data['membersTotalToday'] = this.membersTotalToday;
        data['name'] = this.name;
        data['receivableTotal'] = this.receivableTotal;
        data['refundTotal'] = this.refundTotal;
        data['todayTotal'] = this.todayTotal;
        return data;
    }
}