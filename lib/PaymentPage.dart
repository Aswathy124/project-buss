import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _amountController = TextEditingController();
  String _paymentStatus = '';

  Future<void> _processPayment() async {
    final String url = 'http://localhost:3006/api/payment/payment'; // Change this URL to match your server endpoint
    final Map<String, dynamic> paymentData = {
      'amount': int.parse(_amountController.text),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(paymentData),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _paymentStatus = jsonResponse['message'];
      });
      _navigateToPaymentModeSelection(); // Navigate to payment mode selection page
    } else {
      setState(() {
        _paymentStatus = 'Payment Failed!';
      });
    }
  }

  void _navigateToPaymentModeSelection() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentModeSelectionPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter Amount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    prefix: Text('₹'),
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(

                onPressed: (
                    ) {

                  _processPayment();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Set the button color to blue
                ),
                child: Text('Process Payment'),
              ),
              SizedBox(height: 20),
              Text(
                _paymentStatus,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentModeSelectionPage extends StatefulWidget {
  @override
  _PaymentModeSelectionPageState createState() => _PaymentModeSelectionPageState();
}

class _PaymentModeSelectionPageState extends State<PaymentModeSelectionPage> {
  String? _selectedBank;
  String _accountHolderName = '';
  String _accountNo = '';
  String _ifcCode = '';

  void _selectBank(String? bank) {
    setState(() {
      if (_selectedBank == bank) {
        // If the same bank is selected again, deselect it
        _selectedBank = null;
      } else {
        // Otherwise, select the new bank
        _selectedBank = bank;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Choose a bank for bank transfer:'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBankOption('Federal Bank', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTUlSvs1fingVOoF8yRjMts66FgIgxDMJLvBP5uXh-F8qOwqK8FHeCPTrHbWb3Xcwwiak&usqp=CAU'),
            _buildBankOption('State Bank of India (SBI)', 'data:image/png;base64,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'),
            _buildBankOption('Canara Bank', 'data:image/jpeg;base64,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'),
            _buildBankOption('Bank of Baroda', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr64RsskubRRrOBcuIE0LBWjsm6qRgI71i2A&s'),
            _buildBankOption('Union Bank', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAABVlBMVEX///8BTZoATZjfFB0BTJ3dFR79+vrhExwATZcBS5rhEyAAS5jPAAAATJbaFh0ATZv16OkESZ7HAADWAADw3d7eEyP58/PQAADeFxoESZ/BAADx9Pbh5usASZno7PDz5ucAT5PXABDhvb8AQ5XR3OQAPJOquMcmU4xyjKoAPIu7x9bbAAAAQobcAAvbqqwAP4jp09TWmZxviK7Qh4vPEhzhubvNSEzFYWTMHijpyMrNd3zH0dyRobdVdqCCmLc/Y5VAaZYANHyisMYTTYoxXY1feqHIUFUAQ54US4i3Ljm/ICu9ABUANnmhr8DRcHfakJbNWmK/JzImUoa/TFEAQHrKkpS/aWsANZG4GCAAMIW9Wl3UGCXAeny1AADAQETLNEHqsLPZdnu2Iy3TZWvTa3CuWWHBUVTCmZu+iI3SsrWoMDuhEB2kQky+b3alN0GiIyWreHyTIC3icux0AAAP6ElEQVR4nO2c+1cTybbH+139SPoROk0n0CSVyCNCJ93mHUTxlRnDEeEwZBzAZFREnaOee/7/X+6uBpNmHPF67giNqz7LJaTSHWundu393VXVMgyFQqFQKBQKhUKhUCgUCoVCoVAoFAqFQqFQKBQKhUKhUCgUCoVCoVAoFAqFQqFQzpg7Rbrqfnwf5teXbq882gAe3bm9dGPuqvvzNzO3dOvu8lqtrGkaq3jlcm357sqNq+7U38fc+ua9xTIHsAYrK5oma0I6XVtcXvoxBnLu/kYNhk5gZZbjBEHgIlOLRdnwFjduXnXv/gZubq6lPcXIgYUaq4GFGssqimIJWrpo1B6sXHX//r8sPLzHGorieR7LcrIsF9OReZalKGwOxlNZfHi9p+PSclkhJhkKjJ7FCkqRMziWA4NlGEloZbna3ets4sqa51k5WU5z0QyEichaORYiDbSwrCxzaVlmy8vXNt4sbFRyOcUDh1QETS7KbFEmo6cpnkGsZRWWE7iiYWmb18BEx7bNP7ctPCqzgpWWSXQxWDZtCFa5svbgn8u1xYpGxhAwDFYQimu3r6LP34IU7rTG/V7hfOvGogHuCPk98k/hp8XK5v2bN+aB9fsba4tWjrxr5Sy2qP08fzUd/7/SfbyKXIRmBt1460rFKhbJEHkKGFF+cOt8egcjPYVMThAARnnzUjv8rdhjHbmuyvO4HlPUS0UInLIAYZSVBW1tZf3Pt80trXkWEQAkzN5LdDytY951+ayO/JiFCw8tqyiDJ0IS5CrL639VTaz/TKYop2mWUblzef39drZ4xKtIFBGuThtXapYgF3OWkU4La3e+UC2tL0MoEjgWRvFugmeinVd1pCKdR7F5uHBPEQyuCN23vHtf1p63y6DjZBby/oPPvDg5VDM8IhaKqGVPGm8v5gRICB6bFipLX7537h+gyA0oqOTyk0vo6n/Jti9ClOFhGvYmbXObliLIgpFT5LULDGSYW2uCIgtcWsmtJDbrm31fzxIL3dlw0rj+wFAM2TIsobZy4YrFzRqxUEkLyqPEWtjtuOKphZnpNFwqy5ycthRWuLdw4d03at6phcbdiy+8QqoNiKKRhc8mbXO3wEIQo4LsbZy72Ame9kI7NqrzayBODVbjtOWkWij1dJEnFqp4Z9K4cNeTwT6wsHY/fnF32MEYP6s7k5b5ogcGQunILic1XTh9UScWqiKOTcOKBkIUCkJuLa5VCgNfB3WHMk8nTcRCqPm1tJZYC+2GyqskloqNYNJ4p2yQfrOytxnzPXMPqa4uiirqTNrASwVZgTFUEjsPqxhGEIk8j1rT8umhx5LiSJbLcTFW1VEW6WAi2p20rVfAlQWw0NtIaizdwZDtwUIX9yYBZK7CcWxkYy2WDJ1t34VvQuRFPE2cSxXBiCzUEpsPt5CrQqhR46L05q/EQs3SuOXYNLQ7rq7r4NLZWFrZ9ASyRMWx5aQWwXYeFJsKboo6027DNITx0zxNi7teMwPq3BVVMTuelsq/pAWQbJyseElVbeEsGAhuqvqtabc3yiClIcfJtfg0bLtZiLquq7vbk2wxf4/1tLQMUamYVOW9jaK6CYn+9qRt/Z/W6cqaXIl3u4GizOm6MX++XQHZbXnFYi6pobTQBwuz0OvszDQbLq2dWpg2ajEnDVJgITi0GC+yVmoGl85BqfzTo8vs9jfQHYCTgoV6NhPLhosWJ0O6l8vLsUvDGaSrJHP6e5O0snBXM4y05cnCYlIDTVXXVcRD9HCnSXzhLshRDXqtxOOj1F5FpMrSeb8+aVyXOYEtWlbR+C2hisbpgYWgU1Ren4rS+aJSFBSFY4X4NLRHPiLqTkep6TS8X+YsrSjkZG/tMrv9DZgtiP4ILESZ6TS8WWGh06wlnxPT3Q5CWZXon/zESaU7XtpKw8XCT5uX2e1vIGjooLl5Ufcb0wWMR2UBOq0Iae9WLNCEmCdJRY9LtoW7aS9nFD2BqyU2G2IoDSF6ZHFMlP7iWTI4H3Q7Vjk52+jUQhSTbDdqRbAQ6qzzJUiS2IFcoWZBpeBeLIkbOajvYWDiy2fmLu+eWqg3J403K7KX02TP8h4mNBuCKBVFCDX8uSReky1ZJgVwXLKVMi6Zg1ndH0y1z6YnszCArGzdSqjsdvJIFXVEcsU0iT/yOEj4nGKV4/vXdQzSVRSzon88LfDXyIKjwMlc+dxKQIIIUryqg4W8358MzI1lqPUEwbOsSnwheBeTXAFBN6Z95n8z0lCBcGm5mNTzCtVZEao9CDV+e9K2VAOlCUpFsCqxK828SkpDULCd0qTx9iJLTi2kOSOxS/r7qaxL1qDUmExZKssyWcEo1uKrbNWMSr4L/ty6+K2yRmrftFG+dYmd/ibqmCzQgIUx11v/mWUNsFH7R7yuqPt8VN/rfnuyErCwSc5jsJwl1JIqSpkesVCF0ZmJbTrdqVhpLq39HF/ML/R9UmGpYnwarj+AKpljIdQkd/OwjrN8VC7ELWRuL1cqD85viHY7kAij8jC2gAGiVFPIVr5Wu6wOfzN1TMIMJP3VMN68sL4+fz6/hTqpQfSsqm9N2uZu5WSNLDkq3sPL6e5/QZgi66QiUv3hhdfZu5AICQhPgy4UWYriaRpnJTYbEqECqg1mou72PztqEmcI/kmWEcFJp+58o8YpigIW5mpJXaKBAJJBiEgxPr7Q9jnVFKieqDhEsRJkCUQpjCFEmsSu5zNEl/JgYhYhPHS+dI1UbxDbXCgtVPxiuu20UZY1ReMUrpxUUUrYxq5Ltrcxv9X8wiVOrxF5MpQWvBg/cPMLyRSsocjJzYZMtMiLxKyLXBEN7L+8IhhisstPhEFWx7GANP+rHC39a2xiRSnBbPmQAkjZx6NB87PtbMlsZ3yV7L4hsk/sPou58pNfDRa8VFCSK0ojoMiHlAiSU3TFTi84957UrUNF4cN7ZKkbqqxG3JPvLAqKpiiG5iV1pfQUe+S7ug4mQC5AePdD9VMVJQVhu4N13nWJmCE1pJ6qx+8EcQfZwuC435LspAzJBGR4Iv2NXB3PZp71t7e3d3YbqRkiRcGHRRA9oq67s+cMZBZ+8TzBEtJriT/n3fah/2SHNAK5Lq9jTIaViHKebNuA3lZVPdX70zS9uVmrLC4+fJL4x2fsEVnIgMlG7CMRRdThj05UNtk45cFJXV5UM/XPEubC+pMnN5O6AhXH3sPgjDBeUN4SiaNGu21ECsBPsFTl1SzufCldXgvsMcRLcrxUJFGTj/ZLySCSPEImIXIb7dLXPybJ2Ad5iDLk0JCuR77K62JU0ItZMp6r+fCLku7aUB1g1SVhBUU1BGgYMngumYp4VL+w7rguBPXd0+ACg6iTBYvoZBDCmVH412ru+iEV6o/zKZ+YFc09BCkjs3VQ+iHGb0Jhf7gz7hw2Go3Dzrg/rHev//T7HCfolprNZqkb/FiDR6FQKBTKBNM0nfO/nHvvq6WsY57xFSXgfPWK78VBqxWtRBRGrVH1/FtBv38Q/NU9MaR665R+r3rRdc5Rq3XhBd8N8zl/evKpmffzf1rFD1OrF29dAM5OQ8e+72MXz1xkgT1aTV1NPVmaRacHEHs+2vqTG1Xb7f2v3W93VLd1snMyBll+cIEblhp+p/Dlt78j4QzKRx079tH4bOYFpVJUHZlmIZqGDlGl0dcgwfvwslSaTM8uRrslx3HsBkLRXrfULZ3dLhVg5sHFkWeE2N0xo8+/7MJr6OvRkbTCnouPGXPY32vWR53OCLrl7LX2SO+aOx2oLMZktjb3WsPf21BpHH0arhCj05PSW260dFpqd6AIGZGx3x+1es2DTudZXYLpKpJj/81+a+/ocg00++h036H7jByBajZ8dSavI391BE0pn5w4PMr4uHOI/BRM1zZGfmYL+6jxaU61MD6xCwW7h/EIrN7PrB72d30/DyP1GOZmpgFztNOFf0fXq0yYwY3wgt58D7qDs/3NKua3bPjbxzvNcBe6S4ZH7USPWqbCbrPj+icOM/DRIOy+SrmHn5bZtlwx2+l0Gph/AUYVnjc6XcfOuySqHLruOGy2sD8IYLqiTrOayeYvfXmueehGz/1IT7E4MpmnM+6uzUgHPu6T2KP3wXtPB/kF9lsFJx8dOe2C6Wdj6GR85M/MzPh8gxz8Ov0vCoK8mrHhbzf1e/Q9jQPwBzfb6vhXsP4YYj56TsI8QPjYMU9c8iQXcd2QcU6IOdWGe2gyElOdQS2zOYuegwXw49MRoWoGNV48rddfddTUHvmcbth+mUf+Fnx0Rs8z0dk3SDn1FOJFF7+69KTvvNLFHfKvFgY8GFXYjbaSwHVhYAN40WXqs6hPLhhif4fZx9FJWej0zllX61iPHlCUdjAawJ0jnNlqjV08Ji6Aic0jTJ6z7WOebOg0Lto3/y6YLb0RPQnSxDw4XpBHu9CHZoMfFCCDoU7BgZ6/cCSy9T1TZ7Zx9gAu3uXxpw2Z41MzGKnt6y34UvxOWHAg6vQYpx/FJqbjkvNEh1htjA/d2EHby7Jw1ODHgWPaW64OHhTCQDlR7iIvIOg4zitMPFKCYdsyzX6WHFiX8ih1Np/skY+fmhBK64dqoyn1ZsgZHLtFjhAFYx/Dt2VnXJBKdp48yLjti88v20L4unk8eNU6zKJ8QB7xIWdonLY7+5Q8lEb+v4hQ5/Fxtddw81XivTggxzP9zNk0hBbUGY/HHfiYYwnmr3/c7R676NBmShA9bbJR54OiqIKdZC6rqUvXpsFL30fYd/PPSHAcoBSkanOMIYOYY5/kkWC34fo6xvkQ8rWOyFng6qz/6RAUZJdV319dXZ19PgSx08auPtiCfAkCLcz4e+AP9ZlVuPjpjL9LBt9fbV/6vpvZ64/HrZNoE8J53T4gSe11exgwheGrIckj5nA0Hp30yKC9e32wD9e9OWif6RKp+rrdbg+H7Q9hJOqC9u7o5Pdg2G7b0puDgzdgzdt2+ykjvW2/fgfv1+HOK1gtLwRd+ywySpI0/XH2AqZScPb/8Jx7+1NL7BVZWQ2c6f2ff9a5iymUqyR4Q3RSKT7lgoLz7gfa8fgj2t//V6ymd14HztsfwcLC0dFbxwmfEUHgPA6cUncfiuVC9ai0ZxZs8kvzepsZvC/Z4ZHZ7nchZJYOpOqzsPqy6xzU3w2OpWEovQ+bL6/15r/zgXT/o1mPVOv+kOmBDB0E4QfIhPvMxxJjS8H1trBwAgHGeW8OIyvImNmM+d45AHk6rDL/toM//qc+utb74+YeWAheOiJp3Xwf2I9B1w2lPVDeL7vd1w4Y/Hv7q5+SaPZfl97+IZX+IL8H/2He/Ydhjt4yRx+P9j6ab46cjx/e7n28miXFv42gCg4qReFSAiUOv5BtgVKXiV4UqgWmS2UbhUKhUCgUCoVCoVAoFAqFQqFQKBQKhUKhUCgUCoVCoVAoFAqFQqFQKBQKhUKhUBLE/wKAI+U7tK16RAAAAABJRU5ErkJggg=='),
            _buildBankOption('Axis Bank', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAARMAAAC3CAMAAAAGjUrGAAAAhFBMVEX///+AAAB5AAB1AAB6AAB9AAB2AADi0dH+/PyNNDTRt7eFFhbEoqLNsLCJKCjm2Nj48/P07e28kpLt4uLCnZ2sdXWLLS1wAACxf3/Xv7+ZT0/JqamWSEieWlqIIyPw5+fbxsaiYmKRPT28k5O2iIicVVWnbGyGHByzg4OQOzuDERGqcXHuYtjYAAAGsUlEQVR4nO2aaVujPBSGyQrW7ottrVpcRqvz///fewIEEoLoNZYXpvPcXyohpuHp2ZIQRQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPBXkvQ9gQFyM+97BoNjv33tewqDgzEx63sOA+OZM3XV9ySGxVwwxvSo72kMikdFmjDV9zSGxMyYCWPype+JDIirzEwozC76nslgmOhcEqZ+9T2VwVBYiTGUtO+5DIQXWWrCrvuezDBYiEoSxsd9T2cQ3CtHE6ax7Imi2DUTCrO/v+jfVWqauwvzVUdf8k0ePDP5ctkz187FLI5j+/cxjlOysUXVdDzsNqdJsAcRG1ZB88712smdf9OOSh/Wjuf0d9o61T/mwH1JmHpv7b8Rztzjrd4WlwnX4pY+R1udl8PJvZAEF2t/gGSrDeIu9ZoXwq2iR+LKE+2w1W/mk76v+MlWSoutP8S5SOqSMLZt846VYNyZ7ZLbOu+XYsrcGPE8d82VYlwzzZn2NyES8lWuuVLbpdv8qORzdTXiirnTmPB8hSqYzjVJNVNvHbnxTtYlaS/wb5Xf4Ublkz3owumsJhS51Z4+J0JMj+4IpAlPV/FOs21ctZrVhRPeaRTFHSeuazKmQW7/4HG/w1EEZiLb+qemv3BSEw3A1/lH/rNbTahhnzek/hCkiTYhdC3'),
          ],
        ),
      ),
    );
  }

  Widget _buildBankOption(String bankName, String imageUrl) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          _showPaymentDetailsDialog(context, bankName);
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: _selectedBank == bankName ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(width: 10),
              Text(
                bankName,
                style: TextStyle(
                  color: _selectedBank == bankName ? Colors.white : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentDetailsDialog(BuildContext context, String bankName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Payment Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bank: $bankName'),
              SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  _accountHolderName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Account Holder Name',
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  if (value.length == 11 && int.tryParse(value) != null) {
                    // Valid account number
                    _accountNo = value;
                  } else {
                    // Invalid account number
                    // You can show an error message or handle it as per your application's logic
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter Account Number',
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  if (_isValidIFSC(value)) {
                    _ifcCode = value;
                  } else {
                    // Invalid IFSC code
                    // You can show an error message or handle it as per your application's logic
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter IFSC Code',
                ),
              ),
              SizedBox(height: 20),
              Align(













                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate the input fields
                    if (_accountHolderName.isNotEmpty &&
                        _accountNo.isNotEmpty &&
                        _isValidIFSC(_ifcCode)) {
                      // All validations passed, payment success
                      setState(() {
                        _selectedBank = bankName; // Update selected bank here
                      });
                      Navigator.of(context).pop();
                      _showPaymentSuccessDialog(context);
                    } else {
                      // Some fields are invalid, show error or handle it as per your application's logic
                      // For example:
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill in all details correctly.'),
                        ),
                      );
                    }
                  },
                  child: Text('Continue'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isValidIFSC(String ifsc) {
    // Regular expression for validating IFSC code
    RegExp regex = RegExp(r'^[A-Za-z]{4}[0][A-Za-z0-9]{6}$');
    return regex.hasMatch(ifsc);
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    if (_selectedBank != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Payment Success'),
            content: Text('Your payment using bank transfer to $_selectedBank was successful.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Show error dialog if no bank is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select a bank before continuing.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}