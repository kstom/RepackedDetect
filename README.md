# RepackedDetect
Android Apk 重打包检测

# Usage

## 1. 生成token信息
说明：需要先使用`serverManager`工具来生成客户端sdk集成，以及服务端数据查询用的token，分别记位：`Client Token`以及`Server Token`

Token的生成依赖于三个参数，分别位：
- apk的包名，即packagename
- 签名md5信息（可使用`keytool -printcert -file CERT.RSA`或`keytool -printcert -jarfile xxx.apk`来获取到）。
- 随机key，自定义字符串。

可参考脚本se_gentoken.sh，例子如下：
```bash
packagename="com.village.security.demo"
sign_md5="2A:2D:6D:18:95:33:5A:AA:A4:5E:EC:E5:AE:B0:D9:4A"
key="test" 
./serverManager_mac -g -p "$packagename" -s "$sign_md5" -k "$key"
```

使用生成，结果如下：
```bash
[Gen Token]
GenToken Init new public/private key
----------------------------------------------------
[Client Token]:WxTLFOGfRI4AU8oP6dZOtxR29Bq00jffAVHNXZfcTcVBhvF1yGklsgCsiGPMLnHWO/PEU7UnbPMHuOR9vhtcwl7JFFC+BOHGTZ80B4ft27aoPc2Xf5s4WfbpWaqPxWcFmz3ffRu1V/WbPd99G6VH5Zs9330btVf1mz3ffRuFZ8VbPZ9927UX9Vs9n33bpQflWz2ffdu1F/VbPZ9928VnhRu9332bNVf1G73ffZslR+Ubvd99mzVX9Ru9332bBWfFW70ffds1l/VbvR992yWH5Vu9H33bNZf1W70ffdvFZwWbPd99G7VX9Zs9330bpUflmz3ffRu1V/WbPd99G4VnxVs9n33btRf1Wz2ffdulB+VbPZ9927UX9Vs9n33bMR8JbxKkuUSm9tAFgOf333F45/wnR7ec+letD+kona9N4ovnEi2fsYElU8Ckz33p+KKg1GWXIMF76crlNbr6fnZPrJg42HgYuFj4mDjYeBi4WPiYONh4GLhY+Jg42HgYuFj4WDiYeNi4GPhYOJh42LgY+Fg4mHjYuBj4WDiYeNi4GPgYuNh4mDhY+Bi42HiYOFj4GLjYeJg4WPgYuNh4mDhY+Fi4GHjYOJj4WLgYeNg4mPhYuBh42DiY+Fi4GHjYOJj4mDjYeBi4WPiYONh4GLhY+Jg42HgYuFj4mDjYeBi4WPhYOJh42LgY+Fg4mHjYuBj4WDiYeNi4GPhYOJh42LgY+Bi42HiYOFj4GLjYeJg4WPgYuNh4mDhY+Bi42HiYOFj4WLgYeNg4mPhYuBh42DiY+Fi4GHjYOJj4WLgYeNg5mPk=
----------------------------------------------------
----------------------------------------------------
[Server Token]:CiRwUWJHcys3Y3VoYmJ1SDN0TytKWEt5a0s3MDZSL3hYdC9nPT0=
----------------------------------------------------
```
执行后会在根目录下生成`seTokenInfo.db`文件，该文件会存放输入的`包名`以及`签名md5`信息，可用于对客户端采集上来的数据做重打包判断。

执行`./serverManager_mac -g xxx`生成的客户端以及服务端token。
- [Client Token]，用于客户端sdk函数调用的输入参数，详情见下面`Client Android`节。
- [Server Token]，用于服务端对客户端采集上来的数据做校验，判断是否存在重打包，详情见下面`Server Check`节。

## 2. Client Android

### Application中初始化sdk
```Java
public class MyApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        SecuritySdk.InitSecuritySdk(this);
    }
}

```
### 调用获取apk信息
调用`SecuritySdk.getCollectorMsg(clientToken)`函数会采集客户端apk信息，app开发者将该信息上报到服务端，做重打包校验，实例代码如下：
```Java
public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        String clientToken = "WxTLFOGfRI4AU8oP6dZOtxR29Bq00jffAVHNXZfcTcVBhvF1yGklsgCsiGPMLnHWO/PEU7UnbPMHuOR9vhtcwl7JFFC+BOHGTZ80B4ft27aoPc2Xf5s4WfbpWaqPxWcFmz3ffRu1V/WbPd99G6VH5Zs9330btVf1mz3ffRuFZ8VbPZ9927UX9Vs9n33bpQflWz2ffdu1F/VbPZ9928VnhRu9332bNVf1G73ffZslR+Ubvd99mzVX9Ru9332bBWfFW70ffds1l/VbvR992yWH5Vu9H33bNZf1W70ffdvFZwWbPd99G7VX9Zs9330bpUflmz3ffRu1V/WbPd99G4VnxVs9n33btRf1Wz2ffdulB+VbPZ9927UX9Vs9n33bMR8JbxKkuUSm9tAFgOf333F45/wnR7ec+letD+kona9N4ovnEi2fsYElU8Ckz33p+KKg1GWXIMF76crlNbr6fnZPrJg42HgYuFj4mDjYeBi4WPiYONh4GLhY+Jg42HgYuFj4WDiYeNi4GPhYOJh42LgY+Fg4mHjYuBj4WDiYeNi4GPgYuNh4mDhY+Bi42HiYOFj4GLjYeJg4WPgYuNh4mDhY+Fi4GHjYOJj4WLgYeNg4mPhYuBh42DiY+Fi4GHjYOJj4mDjYeBi4WPiYONh4GLhY+Jg42HgYuFj4mDjYeBi4WPhYOJh42LgY+Fg4mHjYuBj4WDiYeNi4GPhYOJh42LgY+Bi42HiYOFj4GLjYeJg4WPgYuNh4mDhY+Bi42HiYOFj4WLgYeNg4mPhYuBh42DiY+Fi4GHjYOJj4WLgYeNg5mPk=";
        Button btn = findViewById(R.id.button);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String collectMsg = SecuritySdk.getCollectorMsg(clientToken);
                Log.i("SESDK", "msg: " + collectMsg);
            }
        });
    }
}

```

## 3. Server Check
服务端使用`serverManager`来对采集上来的信息做校验，判断当前包是否存在重打包问题，可参考`se_check_collector.sh`脚本。
```bash
collectorData="QOfB2Xq69pndorTXdVL7shV5OEHen1Ru+lk87yuXyJw37EZXW3kcVNlDPTBB7gLdb72wDjINdGeyU8hShpG/xg9UbctWAT/Vp6JH6/7ULUxUDODF9Z2P1QukRCt60KMytxd3+Xp7oRDJNhd61/8KiqVaB6WbJnS4eDt2KSBImWXIdQGskuWEVLqYGhiU96uqYE7GGc3fvbmVKCxWOgKmz6t296Aq0whr9ZTkMPVZOGwGMirKAYPH5GRn6yUMA3YOMAxI6VgtdqqZ61RSulPofKujPIp+gEhj/2W3VAfzauj8+dgTPsTN9+OHCrF/+gZiMOU5conOcIVMcDhsWAHgpz+ksJuXGi3o/jfy5lFMG15j+3malUW2lU9ll2mHfksfvMsZNr0zAtEfykWpjxpyLXN0c2NmqwHzkG1e1OYL4fM54soBrzG4AKk72QKBgZBsxVtQS96yGdTY9CGMFpXUeO6vy30IETKw4uZrT/PGtrsgTi3ZfJaYg5mAHehv11TDGaFZ8i2nk25UQY/J7vfjWZLDvcNh0nK2uijfOwgiKFdMyg1epDEdAprTIqVmOfK6FH0vHAsG2cpvF0PLnPD2omzjPLFtb433g/Fc3OVbFuXFlnjfTqtSi31FAZd+I5EpQhTQ8iss8jRjEJvqdvk9iMRKn+3VDViWiJA4IElxVEOswu7z40OtiuFUEjwYoP8M9iEiQhtB3qxKfX3imzVFeLiZae+BEMv6JoBVCg05txWCbIiGKSstBfPEjrx/g9fGYizSgLeaGNxaaFQD7ClAobneXuEoNaoXCAsn9mrBYKgTHC3P4PSjZEt15hsQk97UpQ=="

serverToken="CiRwUWJHcys3Y3VoYmJ1SDN0TytKWEt5a0s3MDZSL3hYdC9nPT0="

./serverManager_mac -c -l "$serverToken" -t "$collectorData"
```
注：`collectorData`为由客户端调用`SecuritySdk.getCollectorMsg(clientToken)`采集上来的数据，`serverToken`为`步骤1`中国呢生成的`[Server Token]`

## 4. 错误码判断
执行`serverManager -c xxx`后会输出错误码信息，来判断当前是否是重打包，日志格式如下：
```bash
[Check Collector Data]
errno :2048
```
上面日志表示错误码为：2048。

错误码目前使用到8个bit来表征。

各个错误码代表含义如下：
- errno & (1 + 2 + 4 + 8) != 0 : 数据格式有误被篡改(serverToken/collectorData)
- errno & (16 + 32 + 64 + 128 + 256 + 512 + 1024) != 0 : 检测到重打包。
- errno & (2048 + 4096) ！= 0 : collectorData数据过期。

