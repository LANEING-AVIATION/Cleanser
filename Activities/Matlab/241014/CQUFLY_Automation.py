import os
from pathlib import Path
from datetime import datetime

# 指定要扫描的绝对路径
directory_to_scan = '/mnt/d/TPDIR/航模社/重庆大学学生航模协会/重庆大学学生航模协会'

# 获取指定目录下所有文件
def scan_and_sort_files():
    files_with_dates = []
    
    # 使用Path对象递归查找指定目录下的所有文件
    for file_path in Path(directory_to_scan).rglob('*'):
        if file_path.is_file():  # 只处理文件
            # 获取文件的修改时间
            file_stat = file_path.stat()
            modification_time = file_stat.st_mtime  # 修改时间的时间戳
            
            # 转换为日期格式 "YYYYMMDD"
            formatted_date = datetime.fromtimestamp(modification_time).strftime('%Y%m%d')
            
            # 保存 (日期, 文件路径)
            files_with_dates.append((formatted_date, str(file_path)))

    # 自定义排序规则：10月到次年9月
    def custom_sort_key(file_tuple):
        date_str = file_tuple[0]
        date_obj = datetime.strptime(date_str, '%Y%m%d')
        # 自定义排序：10月为起始点
        return ((date_obj.month - 10) % 12, date_obj.day)

    # 按自定义的排序规则对文件列表进行排序
    files_with_dates.sort(key=custom_sort_key)
    
    # 输出结果
    for date, file_path in files_with_dates:
        print(f"{date} - {file_path}")

# 执行扫描和排序
if __name__ == "__main__":
    scan_and_sort_files()
