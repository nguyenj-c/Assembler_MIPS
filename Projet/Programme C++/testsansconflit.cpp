#include <iostream>

using namespace std;

namespace
{
    const unsigned N = 8;
    unsigned Colonne[N];

    bool SansConflit(const unsigned &Lign, const unsigned &Coln)
    {
        unsigned i1, j1, i2 = Lign, j2 = Coln;
        for (unsigned k = 0; k < Lign; ++k)
        {
            i1 = k;
            j1 = Colonne[k];
            if ((i1 == i2)                   // meme olonne
                || (j1 == j2)                // meme ligne
                || ((i1 - j1) == (i2 - j2))  // meme diagonale
                || ((i1 + j1) == (i2 + j2))) // meme diagonale
                return false;
        }
        return true;
    } // SansConflit ()

    void tester()
    {
        for (unsigned i = 0; i < N; ++i)
        {
            for (unsigned j = 0; j < N; ++j)
                cout << SansConflit(i, j) << ' ';

            cout << endl;
        }
    }

    void test1()
    {
        // solution n°1
        // 0, 4, 7, 5, 2, 6, 1, 3
        Colonne[0] = 0;
        Colonne[1] = 4;
        Colonne[2] = 7;
        Colonne[3] = 5;
        Colonne[4] = 2;
        Colonne[5] = 6;
        Colonne[6] = 1;
        Colonne[7] = 3;

        tester();
    }

    void test2()
    {
        // solution n°92
        // 7, 3, 0, 2, 5, 1, 6, 4
        Colonne[0] = 7;
        Colonne[1] = 3;
        Colonne[2] = 0;
        Colonne[3] = 2;
        Colonne[4] = 5;
        Colonne[5] = 1;
        Colonne[6] = 6;
        Colonne[7] = 4;

        tester();
    }

    void test3()
    {
        // 4, 2, 0, 7, 7, 0, 5, 1
        // valeurs choisies délibéremment
        Colonne[0] = 4;
        Colonne[1] = 2;
        Colonne[2] = 0;
        Colonne[3] = 7;
        Colonne[4] = 7;
        Colonne[5] = 0;
        Colonne[6] = 5;
        Colonne[7] = 1;

        tester();
    }
} // namespace

void printUsage()
{
    cout << "Usage: TestSansConflit.o {1,2,3}" << endl;
}

int main2(int argc, char **argv)
{
    if (argc != 1 && argc != 2)
    {
        printUsage();
        return 0;
    }

    if (argc == 1) // pas d'arguments
    {
        test1();
        cout << endl;

        test2();
        cout << endl;

        test3();
    }
    else
    {
        switch (argv[1][0])
        {
        case '1':
            test1();
            break;
        case '2':
            test2();
            break;
        case '3':
            test3();
            break;
        default:
            printUsage();
            break;
        }
    }

    cout << endl;

    return 0;
}
