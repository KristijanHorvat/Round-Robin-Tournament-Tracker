List<String> generateCompetition(List<String> competitors){
    List<String> competition = [];
    if(competitors.length == 4 || competitors.length == 3){
      if(competitors.length == 3) competition.add("");
      competition.add(competitors[0]);
      competition.add(competitors[3]);
      competition.add(competitors[1]);
      competition.add(competitors[2]);
      
      competition.add(competitors[3]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
      competition.add(competitors[1]);

      competition.add(competitors[1]);
      competition.add(competitors[3]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
    }

if(competitors.length == 6 || competitors.length == 5){
      if(competitors.length == 5) competition.add("");
      competition.add(competitors[0]);
      competition.add(competitors[5]);
      competition.add(competitors[1]);
      competition.add(competitors[4]);
      competition.add(competitors[2]);
      competition.add(competitors[3]);
      
      competition.add(competitors[5]);
      competition.add(competitors[3]);
      competition.add(competitors[4]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
      competition.add(competitors[1]);

      competition.add(competitors[1]);
      competition.add(competitors[5]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
      competition.add(competitors[3]);
      competition.add(competitors[4]);

      competition.add(competitors[5]);
      competition.add(competitors[4]);
      competition.add(competitors[0]);
      competition.add(competitors[3]);
      competition.add(competitors[1]);
      competition.add(competitors[2]);

      competition.add(competitors[2]);
      competition.add(competitors[5]);
      competition.add(competitors[3]);
      competition.add(competitors[1]);
      competition.add(competitors[4]);
      competition.add(competitors[0]);
    }

    if(competitors.length == 8 || competitors.length == 7){
      if(competitors.length == 7) competition.add("");
      competition.add(competitors[0]);
      competition.add(competitors[7]);
      competition.add(competitors[1]);
      competition.add(competitors[6]);
      competition.add(competitors[2]);
      competition.add(competitors[5]);
      competition.add(competitors[3]);
      competition.add(competitors[4]);
      //kolo2
      competition.add(competitors[7]);
      competition.add(competitors[4]);
      competition.add(competitors[5]);
      competition.add(competitors[3]);
      competition.add(competitors[6]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
      competition.add(competitors[1]);
//kolo3
      competition.add(competitors[1]);
      competition.add(competitors[7]);
      competition.add(competitors[2]);
      competition.add(competitors[0]);
      competition.add(competitors[3]);
      competition.add(competitors[6]);
      competition.add(competitors[4]);
      competition.add(competitors[5]);
//kolo4
      competition.add(competitors[7]);
      competition.add(competitors[5]);
      competition.add(competitors[6]);
      competition.add(competitors[4]);
      competition.add(competitors[0]);
      competition.add(competitors[3]);
      competition.add(competitors[1]);
      competition.add(competitors[2]);
//kolo5
      competition.add(competitors[2]);
      competition.add(competitors[7]);
      competition.add(competitors[3]);
      competition.add(competitors[1]);
      competition.add(competitors[4]);
      competition.add(competitors[0]);
      competition.add(competitors[5]);
      competition.add(competitors[6]);

      //kolo6
      competition.add(competitors[7]);
      competition.add(competitors[6]);
      competition.add(competitors[0]);
      competition.add(competitors[5]);
      competition.add(competitors[1]);
      competition.add(competitors[4]);
      competition.add(competitors[2]);
      competition.add(competitors[3]);
      //kolo7
      competition.add(competitors[3]);
      competition.add(competitors[7]);
      competition.add(competitors[4]);
      competition.add(competitors[2]);
      competition.add(competitors[5]);
      competition.add(competitors[1]);
      competition.add(competitors[6]);
      competition.add(competitors[0]);
    }
    
    return competition;
  }
  