/**
 * FloodFill算法，深度遍历搜索。
 */
#include <iostream>
#include <map>
using namespace std;

struct Cube
{
    bool used;          // 是否已经使用
    int cood[4];        // 坐标
    int neighbor[4][2]; // 相邻标识号
};

void FloodFill(int row, int cnt, Cube *cube, int maxmin[4][2])
{
    if (cube[row].used == false)
    {
        cube[row].used = true;

        int i, j, k, row2;
        for (i = 0; i < 4; ++i)
            for (j = 0; j < 2; ++j)
                if (cube[row].neighbor[i][j] != -1 && cube[cube[row].neighbor[i][j]].used == false)
                {
                    row2 = cube[row].neighbor[i][j];
                    for (k = 0; k < 4; ++k)
                        cube[row2].cood[k] = cube[row].cood[k];
                    if (j == 0)
                    {
                        ++cube[row2].cood[i];
                        if (maxmin[i][0] < cube[row2].cood[i])
                            maxmin[i][0] = cube[row2].cood[i];
                    }
                    else
                    {
                        --cube[row2].cood[i];
                        if (maxmin[i][1] > cube[row2].cood[i])
                            maxmin[i][1] = cube[row2].cood[i];
                    }
                    FloodFill(row2, cnt, cube, maxmin);
                }
    }
}

int main(int argc, char** argv) {

    bool ok;
    int cnt;    // 1 <= cnt <= 100
    int maxmin[4][2];
    int minv;
    Cube cube[100];
    map <int, int> idmap;

    int t, i, j, k, id;
    for (cin >> t; t > 0; --t)
    {
        // 输入数据
        cin >> cnt;
        idmap.clear();
        for (i = 0; i < cnt; ++i)
        {
            cube[i].used = false;
            cin >> id;
            idmap[id] = i;
            for (j = 0; j < 4; ++j)
                for (k = 0; k < 2; ++k)
                    cin >> cube[i].neighbor[j][k];
        }

        // 标识号改为对应的行号
        for (i = 0; i < cnt; ++i)
            for (j = 0; j < 4; ++j)
                for (k = 0; k < 2; ++k)
                    cube[i].neighbor[j][k] = (cube[i].neighbor[j][k] == 0) ? -1 : idmap[cube[i].neighbor[j][k]];

        // 判断是否对称
        ok = true;
        for (i = 0; i < cnt && ok; ++i)
            for (j = 0; j < 4 && ok; ++j)
                for (k = 0; k < 2 && ok; ++k)
                    if (cube[i].neighbor[j][k] != -1 && cube[cube[i].neighbor[j][k]].neighbor[j][1 - k] != i)
                        ok = false;
        if (!ok)
        {
            cout << "Inconsistent" << endl;
            continue;
        }

        // Flood Fill 算法 (种子染色法)
        for (i = 0; i < 4; ++i) cube[i].cood[i] = 0;
        for (i = 0; i < 4; ++i) maxmin[i][0] = maxmin[i][1] = 0;
        FloodFill(0, cnt, cube, maxmin);

        // 判断是否连通
        ok = true;
        for (i = 0; i < cnt && ok; ++i)
            if (cube[i].used == false)
                ok = false;
        if (!ok)
        {
            cout << "Inconsistent" << endl;
            continue;
        }

        // 计算最小体积
        minv = 1;
        for (i = 0; i < 4; ++i)
            minv *= maxmin[i][0] - maxmin[i][1] + 1;
        cout << minv << endl;
    }
    return 0;
}