import java.util.Scanner;
import java.io.File;
import java.io.DataInput;
import java.io.DataInputStream;
import java.util.Arrays;

public class MatMulBinary {
	public static final int l = 300, n = 50, m = 500;

	// Reads out a matrix of prespecified dimension.
	public static int[][] importMatrix(Scanner sc, int height, int width) throws Exception {
		int A[][] = new int[height][width];
		for (int i = 0; i < height; ++i) {
			for (int j = 0; j < width; ++j) {

				if (sc.hasNextInt()) {
					A[i][j] = sc.nextInt();

				} else {
					throw new Exception("Not enough numbers in matrix input.");
				}
			}
		}
		return A;
	}

	// A pseudo-hash for matrices.
	public static char jumpTrace(int[][] m) {
		int w = m[0].length;
		int h = m.length;
		int iterations = w * h;
		int x = 0, y = 0;
		int acc = 1;
		for (int i = 0; i < iterations; ++i) {
			acc = (acc * m[y][x] + 1) % (w * h);
			y = acc % h;
			x = (acc * m[y][x]) % w;
		}
		return (char) (((int) 'a') + acc % 26);
	}

	public static void main(String[] args) throws Exception {
		int A[][], B[][];

		Scanner input = new Scanner(System.in);

		A = importMatrix(input, l, n);
		B = importMatrix(input, n, m);
		int C[][] = new int[l][m];
		for (int i = 0; i < l; ++i) {
			for (int j = 0; j < m; ++j) {
				int acc = 0;
				for (int k = 0; k < n; ++k) {
					acc += A[i][k] * B[k][j];
				}
				C[i][j] = acc;
			}
		}
		System.out.println(jumpTrace(C));
	}
}
