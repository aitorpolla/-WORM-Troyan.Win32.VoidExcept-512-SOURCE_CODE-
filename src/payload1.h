#include <windows.h>
#include <cstdlib>
#include <ctime>
#include <thread>

void moverCursor() {
    srand((unsigned int)time(NULL));
    while (true) {
        POINT p;
        GetCursorPos(&p);
        int x = p.x + (rand() % 21 - 10);
        int y = p.y + (rand() % 21 - 10);
        SetCursorPos(x, y);
        Sleep(10);
    }
}

void bitBltGlitch() {
    int w = GetSystemMetrics(0);
    int h = GetSystemMetrics(1);
    while (true) {
        HDC hdc = GetDC(0);
        BitBlt(hdc, rand() % 2, rand() % 2, w, h, hdc, rand() % 2, rand() % 2, SRCAND);
        Sleep(10);
        ReleaseDC(0, hdc);
    }
}

void dibujarElipses() {
    int w = GetSystemMetrics(0), h = GetSystemMetrics(1);
    int x = 10, y = 10;
    int signX = 1, signY = 1;
    int incrementor = 10;

    while (true) {
        HDC hdc = GetDC(0);
        x += incrementor * signX;
        y += incrementor * signY;

        int top_x = x;
        int top_y = y;
        int bottom_x = x + 100;
        int bottom_y = y + 100;

        HBRUSH brush = CreateSolidBrush(RGB(rand() % 255, rand() % 255, rand() % 255));
        SelectObject(hdc, brush);
        Ellipse(hdc, top_x, top_y, bottom_x, bottom_y);
        DeleteObject(brush);
        ReleaseDC(0, hdc);

        if (x <= 0 || x + 100 >= w) signX *= -1;
        if (y <= 0 || y + 100 >= h) signY *= -1;

        Sleep(10);
    }
}

int main() {
    std::thread t1(moverCursor);
    std::thread t2(bitBltGlitch);
    std::thread t3(dibujarElipses);

    t1.join();
    t2.join();
    t3.join();

    return 0;
}
