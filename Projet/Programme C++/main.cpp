#include <iomanip>
#include <iostream>


using namespace std;

namespace {

const unsigned N = 8;
unsigned SolutionNum = 0;
unsigned Colonne[N];
void AfficherSolution(unsigned Colonne[], const unsigned N) {
  cout << "Solution numero " << ++SolutionNum << ":"
       << "\n";
  for (unsigned i = 0; (i < N); ++i) {
    for (unsigned j = 0; (j < N); ++j)
      if (j == Colonne[i])
        cout << setw(2) << "R";
      else
        cout << setw(2) << "+";
    cout << "\n";
  }
  cout << "\n";
}

bool SansConflit(const unsigned &Ligne, const unsigned &Coln) {
  unsigned i1, j1, i2 = Ligne, j2 = Coln;
  for (unsigned k = 0; k < Ligne; ++k) {
    i1 = k;
    j1 = Colonne[k];
    if ((i1 == i2)    // meme olonne
        || (j1 == j2) // memeligne
        || ((i1 - j1) == (i2 - j2))
        // memediagonale
        || ((i1 + j1) == (i2 + j2))) // memediagonale
      return false;
  }
  return true;
} // SansConflit()
void ReineR(unsigned i) {
  if (i >= N)
    AfficherSolution(Colonne, N);
  else
    for (unsigned k = 0; (k < N); ++k)
      if (SansConflit(i, k)) {
        Colonne[i] = k;
        ReineR(i + 1);
      }
} // ReineR()
void Reine(void) { ReineR(0); } // Reine()
} // namespace
int main() {
  Reine();
  return 0;
}
// main(
