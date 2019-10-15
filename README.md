# liquid_bar_chart


## Animated Bar Chart
![Liquid Bar Chart](https://github.com/mi6ock/liquid_bar_chart/blob/master/readme_files/liquid_bar_chart.gif)

### Description



### Getting started
You should ensure that you add the dependency in your flutter project.

```yaml
dependencies:
  liquid_bar_chart: ^0.0.1
```


## Example

```dart
Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    final List<String> week = ["Sun", "Mon", "Thu", "Wed", "Thu", "Fri", "Sat"];
    final List<String> tooltips = [
      "Good",
      "Bad",
      "So So",
      "A little nice",
      "Pretty good",
      "Very good",
      "Super nice"
    ];
    
    Random rnd = Random();
    for (int i=0; i< 7; i++) {
      barDataList.add(
        BarData(
          value: rnd.nextDouble() * 10,
          maxValue: 10,
          barBackColor: Colors.blue[100],
          barColor: Colors.blue,
          title: week[i],
          toolTip: tooltips[i],
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart Example"),
      ),
      body: Center(
        child: SizedBox(
          height: size.height / 2,
          width: size.width,
          child: Card(
            margin: const EdgeInsets.all(18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.blueGrey[100],
            child: LBChart(
              barDataList: barDataList,
              padding: EdgeInsets.all(8),
              title: "Chart Title",
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _changeData(),
      ),
    );
}

```