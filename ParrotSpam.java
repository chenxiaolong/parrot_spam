public class ParrotSpam {
    public static void main(String[] args) {
        int avail = 4000;
        int total = 0;

        for (String arg : args) {
            total += arg.length();
        }

        if (total == 0) {
            System.err.println("Nothing to repeat");
            System.exit(1);
        }

outer:
        while (true) {
            for (String arg : args) {
                if (avail < arg.length()) {
                    break outer;
                }
                System.out.print(arg);
                avail -= arg.length();
            }
        }
    }
}
