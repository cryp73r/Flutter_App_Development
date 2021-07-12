import 'package:flutter/material.dart';
import 'package:yts_mx/JsonData/getImageData.dart';
import 'package:yts_mx/screens/movieDetailScreen.dart';
import 'package:yts_mx/utils/imageNameFixer.dart';

class ShortDetailScreen extends StatefulWidget {
  final Map? tempData;
  final double? height;
  const ShortDetailScreen({Key? key, @required this.tempData, @required this.height}) : super(key: key);

  @override
  _ShortDetailScreenState createState() => _ShortDetailScreenState();
}

class _ShortDetailScreenState extends State<ShortDetailScreen> {

  @override
  Widget build(BuildContext context) {
    double height = widget.height!;
    Map tempData = widget.tempData!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            smallDetailHolder(height, tempData),
            genresHolder(tempData),
            Divider(thickness: 2.5),
            nextPageNavigationHolder(tempData),
          ],
        ),
      ),
    );
  }

  Widget smallDetailHolder(double height, Map tempData) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            getImageData(imageNameFixer(tempData["slug"]), "medium-cover"),
            fit: BoxFit.cover,
          ),
        )),
        Container(
          width: width * 0.69,
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tempData["title"]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("• ${tempData["year"]}"),
                  Text("• ${tempData["language"]}".toUpperCase()),
                  if ((tempData["runtime"]/60).toString().substring(0, 1)!="0") Text("• ${(tempData["runtime"]/60).toString().substring(0, 1)}h ${tempData["runtime"]%60}m"),
                  if ((tempData["runtime"]/60).toString().substring(0, 1)=="0") Text("• ${tempData["runtime"]} min"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (tempData["rating"]!=0) Text("• IMDB Rating: ${tempData["rating"]}/10"),
                  if (tempData["rating"]==0) Text("• IMDB Rating: N/A"),
                  if (tempData["mpa_rating"]!="") Text("• MPA Rating: ${tempData["mpa_rating"]}"),
                  if (tempData["mpa_rating"]=="") Text("• MPA Rating: N/A"),
                ],
              ),
              if (tempData["summary"].isNotEmpty && tempData["summary"].length>327) Text("${tempData["summary"].substring(0, 325)} ...", softWrap: true, overflow: TextOverflow.fade, textAlign: TextAlign.justify,),
              if (tempData["summary"].isNotEmpty && tempData["summary"].length<327) Text("${tempData["summary"]}", softWrap: true, overflow: TextOverflow.fade, textAlign: TextAlign.justify,),
              if (tempData["summary"].isEmpty) Text("No Summary Available!", softWrap: true, overflow: TextOverflow.fade, textAlign: TextAlign.justify,)
            ],
          ),
        )
      ],
    );
  }

  Widget genresHolder(Map tempData) {
    if (tempData["genres"].length<=5) return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tempData["genres"].length, (index) => Text("• ${tempData["genres"][index]}")),
    );
    else return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.95,
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(5, (index) => Text("• ${tempData["genres"][index]}")),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(tempData["genres"].length-5, (index) => Text("• ${tempData["genres"][5+index]}")),),
          ],),
        )
      ],
    );
  }

  Widget nextPageNavigationHolder(Map tempData) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.info_outline),
        title: Text("View Full Description & Download"),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(
                    movieId: tempData["id"],
                  )));
        },
      ),
    );
  }
}
