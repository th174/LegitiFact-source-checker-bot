package com.example.just_sudo_it.hack_duke2016;

import android.app.usage.UsageStats;
import android.app.usage.UsageStatsManager;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.provider.Settings;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import java.util.List;
import java.util.SortedMap;
import java.util.TreeMap;

public class AppUsageActivity extends AppCompatActivity {

    UsageStatsManager mUsageStatsManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_appusage);
        //Intent intent = new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS);
        //startActivity(intent);
        final Button button = (Button) findViewById(R.id.button1);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                startActivity(new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS));
                AsyncTask.execute(new Runnable() {
                    @Override
                    public void run() {
                            printCurrentActivity();
                    }
                });
            }
        });
    }

    public void printCurrentActivity() {
        UsageStats usageStats;

        String PackageName = "Nothing";

        long TimeInforground = 500;

        int minutes = 500, seconds = 500, hours = 500;
        UsageStatsManager mUsageStatsManager = (UsageStatsManager) getSystemService("usagestats");

        long time = System.currentTimeMillis();

        List<UsageStats> stats = mUsageStatsManager.queryUsageStats(UsageStatsManager.INTERVAL_BEST, time - 604800000, time);

        if (stats != null) {
            SortedMap<Long, UsageStats> mySortedMap = new TreeMap<Long, UsageStats>();
            for (UsageStats usagestats : stats) {

                TimeInforground = usagestats.getTotalTimeInForeground();

                PackageName = usagestats.getPackageName();

                Log.d("App", PackageName.substring(PackageName.lastIndexOf(".")+1));

            }
        }
    }
}
