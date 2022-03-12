import 'dart:io';
import 'dart:core';
import 'dart:math';

//Welcome message
void displayIntro() {
  stdout.write("\n\nYou may bid for up to 5 valuable paintings.\n");
  stdout.write(
      "You start with \$5000. Then, try to sell your collecttion\nfor as much as possible.\n");
}

//Play again
void playAgain(int cash) {
  stdout.write("\nYou started with \$5000. You finished with \$$cash.\n");
  stdout.write("Play again (y/n)? ");
  String answer = stdin.readLineSync();
  if (answer == "y") {
    playGame(cash);
  }
}

/**********************************************************
  * PLAY GAME
  **********************************************************/
void playGame(int cash) {
  //int cash = 5000;
  List<int> ownedPaintings = new List();
  int index = 0;
  int max = 1150;
  int min = 150;

  /**********************************************************
  * BUYING PAINTINGS
  **********************************************************/
  for (int i = 1; i < 6; i++) {
    stdout.write("\nPainting #${i} is up for sale.\n");
    stdout.write("You have \$${cash} left.\n");
    stdout.write("Enter your bid: ");
    String bid = stdin.readLineSync();
    int bidValue = int.parse(bid);
    Random rnd = new Random();
    int _rnd = min + rnd.nextInt(max - min);

    //Checking to see if the bid is within your budget
    while (bidValue > cash) {
      stdout.write("You don't have that much money.\n");
      stdout.write("Enter your bid: ");
      String bid = stdin.readLineSync();
      bidValue = int.parse(bid);
      if (bidValue <= cash) {
        break;
      }
    }
    //Checking if you won the bid or not
    if (bidValue <= cash) {
      if (bidValue > _rnd && bidValue <= cash) {
        stdout.write("Your opponent offered \$${_rnd}.\n");
        stdout.write("CONGRATULATIONS! You bought it!\n");
        cash -= bidValue;
        ownedPaintings.insert(index, bidValue);
        index++;
      } else if (bidValue < _rnd) {
        stdout.write("Your opponent offered \$${_rnd}.\n");
        stdout.write("Sorry, you were out bid.\n");
      }
    }
  }

  /**********************************************************
  * SELLING PAINTINGS
  **********************************************************/

  for (int i = 0; i < ownedPaintings.length; i++) {
    Random rnd = new Random();
    int _rnd = 1 + rnd.nextInt(6 - 1);
    stdout.write("\nYou may now sell your Painting #${i + 1}.\n");
    stdout.write("You paid \$${ownedPaintings[i]} for it.\n");

    //Looping through offers
    for (int j = 0; j < _rnd; j++) {
      Random rndOffer = new Random();
      int _rndOffer = 500 + rndOffer.nextInt(2500 - 500);

      stdout.write("You are being offered \$${_rndOffer} for this painting.\n");
      stdout.write("Do you accept (y/n)? ");
      String answer = stdin.readLineSync();
      if (answer == "y") {
        cash += _rndOffer;
        break;
      }
      if (j == _rnd - 1) {
        stdout.write("Sorry! That was your last offer.\n");
        break;
      }
    }
  }

  //Play again??
  playAgain(cash);
}

void main() {
  displayIntro();
  playGame(5000);
}
