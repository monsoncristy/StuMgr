package cust.slei.domain;

import lombok.Data;

@Data
public class StudentResult {

    private Integer id;
    private double chinese;
    private double math;
    private double english;
    private double physics;
    private double chemistry;
    private double biology;
    private double history;
    private double geography;
    private double politics;
    private double allResult;

    public void sumAll(){
        this.allResult = this.biology + this.chemistry + this.chinese + this.math
                + this.english + this.physics + this.history + this.geography + this.politics;
    }

}