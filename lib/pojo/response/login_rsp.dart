

class LoginRsp {
    String access_token;
    String expires_in;
    String token_type;

    LoginRsp({this.access_token, this.expires_in, this.token_type});

    factory LoginRsp.fromJson(Map<String, dynamic> json) {
        return LoginRsp(
            access_token: json['access_token'],
            expires_in: json['expires_in'],
            token_type: json['token_type'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['access_token'] = this.access_token;
        data['expires_in'] = this.expires_in;
        data['token_type'] = this.token_type;
        return data;
    }
}