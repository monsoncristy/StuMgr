package cust.slei.domain;

import lombok.Data;

@Data
public class StudentTotal {

    private Integer id;

    private double de;

    private double zhi;

    private double ti;

    private double mei;

    private double lao;

    private double total;

    public void sumAll(){
        this.total = (this.de + this.zhi + this.ti + this.mei + this.lao)/5;
    }
}
