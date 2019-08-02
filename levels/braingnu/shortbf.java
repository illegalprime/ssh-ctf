/**
 * Taken from Stack Overflow!
 * https://codegolf.stackexchange.com/questions/5418/brainf-golfer/5440#5440
 */
import java.io.*;

class shortbf {
    static String repeat(String s, int n) {
        StringBuilder b = new StringBuilder();
        for (int i = 0; i < n; i++) b.append(s);
        return b.toString();
    }

    // G[x][y]: BF code that transforms x to y.
    static String[][] G = new String[256][256];
    static {
        // initial state for G[x][y]: go from x to y using +s or -s.
        for (int x = 0; x < 256; x++) {
            for (int y = 0; y < 256; y++) {
                int delta = y - x;
                if (delta > 128) delta -= 256;
                if (delta < -128) delta += 256;

                if (delta >= 0) {
                    G[x][y] = repeat("+", delta);
                } else {
                    G[x][y] = repeat("-", -delta);
                }
            }
        }

        // keep applying rules until we can't find any more shortenings
        boolean iter = true;
        while (iter) {
            iter = false;

            // multiplication by n/d
            for (int x = 0; x < 256; x++) {
                for (int n = 1; n < 40; n++) {
                    for (int d = 1; d < 40; d++) {
                        int j = x;
                        int y = 0;
                        for (int i = 0; i < 256; i++) {
                            if (j == 0) break;
                            j = (j - d + 256) & 255;
                            y = (y + n) & 255;
                        }
                        if (j == 0) {
                            String s = "[" + repeat("-", d) + ">" + repeat("+", n) + "<]>";
                            if (s.length() < G[x][y].length()) {
                                G[x][y] = s;
                                iter = true;
                            }
                        }

                        j = x;
                        y = 0;
                        for (int i = 0; i < 256; i++) {
                            if (j == 0) break;
                            j = (j + d) & 255;
                            y = (y - n + 256) & 255;
                        }
                        if (j == 0) {
                            String s = "[" + repeat("+", d) + ">" + repeat("-", n) + "<]>";
                            if (s.length() < G[x][y].length()) {
                                G[x][y] = s;
                                iter = true;
                            }
                        }
                    }
                }
            }

            // combine number schemes
            for (int x = 0; x < 256; x++) {
                for (int y = 0; y < 256; y++) {
                    for (int z = 0; z < 256; z++) {
                        if (G[x][z].length() + G[z][y].length() < G[x][y].length()) {
                            G[x][y] = G[x][z] + G[z][y];
                            iter = true;
                        }
                    }
                }
            }
        }
    }
    static void generate(String s) {
        char lastc = 0;
        for (char c : s.toCharArray()) {
            String a = G[lastc][c];
            String b = G[0][c];
            if (a.length() <= b.length()) {
                System.out.print(a);
            } else {
                System.out.print(">" + b);
            }
            System.out.print(".");
            lastc = c;
        }
        System.out.println();
    }

    static void genFile(String file) throws IOException {
        File f = new File(file);
        int len = (int)f.length();
        byte[] b = new byte[len];
        InputStream i = new FileInputStream(f);
        StringBuilder s = new StringBuilder();
        while (true) {
            int v = i.read();
            if (v < 0) break;
            if (v == 0) continue; // no zeros
            s.append((char)v);
        }
        generate(s.toString());
    }
    public static void main(String[] args) throws IOException {
        genFile(args[0]);
    }
}
