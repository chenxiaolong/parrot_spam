import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class ParrotSpamStream {
    private static final int MAX_CHARS = 4000;

    public static void main(String[] args) {
        List<String> parrots = Arrays.stream(args)
                .filter(x -> !x.isEmpty())
                .collect(Collectors.toList());
        if (parrots.isEmpty()) {
            System.err.println("Nothing to repeat");
            System.exit(1);
        }

outer:
        for (int c = 0; ; ) {
            for (String parrot : parrots) {
                c += parrot.length();
                if (c > MAX_CHARS) {
                    break outer;
                }
                System.out.print(parrot);
            }
        }
    }
}
