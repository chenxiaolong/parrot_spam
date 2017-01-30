using System;

class ParrotSpam
{
    public const int NUM_CHARS = 4000;

    static int Main(string[] args)
    {
        var parrots = Array.FindAll(args, a => a.Length > 0);
        if (parrots.Length == 0) {
            Console.Error.WriteLine("Nothing to repeat");
            return 1;
        }

        for (int c = 0; ; ) {
            foreach (string p in parrots) {
                c += p.Length;
                if (c > NUM_CHARS)
                    goto Done;

                Console.Write(p);
            }
        }
    Done:
        if (!Console.IsOutputRedirected)
            Console.WriteLine();

        return 0;
    }
}
