public class MyController1{

    public Boolean panel1 {get; private set;}
    public Boolean panel2 {get; private set;}

    public MyController1() {
        panel1 = true;
        panel2 = false;
    }

    public void displayPanel1(){
        panel1 = true;
        panel2 = false;
    }

    public void displayPanel2(){
        panel1 = false;
        panel2 = true;
    }
}