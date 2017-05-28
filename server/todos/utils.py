from datetime import datetime, timedelta
import pytz

def time_str_to_sec(time_str):
    hh = int(time_str[0:2]) * 3600
    mm = int(time_str[2:4]) * 60
    ss = int(time_str[4:6])
    time = hh + mm + ss
    return time

def time_str_to_datetime(time_str):
    hh = int(time_str[0:2])
    mm = int(time_str[2:4])
    ss = int(time_str[4:6])
    today = datetime.now(pytz.timezone('Asia/Seoul'))
    if today.weekday() > 4:
        today = today - timedelta(days=today.weekday() - 4)
    elif hh < 9:
        today = today - timedelta(days=1)
    now_datetime = datetime(today.year, today.month, today.day, hh, mm, ss)
    return now_datetime

def today_date():
    return datetime.now(pytz.timezone('Asia/Seoul')).date()

def datetime_to_sec(datetime_obj):
    hh = datetime_obj.hour * 3600
    mm = datetime_obj.minute * 60
    ss = datetime_obj.second
    time = hh + mm + ss
    return time


def nowtime_to_sec():
    # Local time
    nowtime = datetime.now()
    hh = nowtime.hour * 3600
    mm = nowtime.minute * 60
    ss = nowtime.second
    time = hh + mm + ss
    return time


def sec_to_string(value):
    hh = int(value / 3600)
    mm = int((value - hh * 3600) / 60)
    ss = int(value % 60)
    hh = str(hh).zfill(2)
    mm = str(mm).zfill(2)
    ss = str(ss).zfill(2)
    return str('{}:{}:{}'.format(hh, mm, ss))