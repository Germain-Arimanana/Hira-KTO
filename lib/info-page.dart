import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class infoPage extends StatelessWidget {
  const infoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Momba ny rindrankajy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Markdown(selectable: true,data: 
        """
# **Fihirana Katolika**



#### Fihirana Katolika dia rindrankajy iray ho an'ny finday misy iOS sy Android, izay novolavolaina tamin'ny [Flutter-Dart](flutter.dev). 
#### Ity rindrankajy ity dia manampy anao hitady ny hira hira ao amin'ny Fihirana Katolika , amin'ny alalan'ny lohateny na laharan'ny pejy.
#### Izany no natao mba ahafahanao mikaroka sy mijery ny hira amin'ny fomba mora sy haingana.

## **Ireo Mampiavaka azy:**

#### **- Fikarohana hira:** Afaka mitady hira ianao amin'ny alalan'ny lohateny na ny laharan'ny pejy.

#### **- Endrika:** Mety ho an'ny rehetra, manana endrika tsotra sy mazava ny rindrankajy mba hanamora ny fampiasana.

#### **- Open source:** Ity tetikasa ity dia open source izany hoe afaka misokatra ho an'ny rehetra ny rindrambaiko ary azo ovaina, 

##### **- Fisaorana:** Isaorana Manokana ho an'i  **[Eugene Heriniaina](github.com/heriniaina)** , **[Katolika.org](katolika.org)** sy ireo **namana namolavola sy nampiditra hira** ary ianao izay efa nampiasa ity fitaovana ity .

#### Mpikirakira sy namolavola: **ARIMANANA RAMILA GERMAIN VICTORY**
"""
        
        
        ),
      ),
    );
  }
}