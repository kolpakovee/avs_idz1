# avs_idz1
вариант
о программе 
ввод 
вывод
## 4 балла
![4_1](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/4_1.png)
- В проекте это файл main.c
---
![4_2](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/4_2.png)

- Компиляция без отладочных опций:

![compilation1](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/compilation1.png)

- После компиляции создался файл first.s, комментарии написаны в нём
---

![4_3](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/4_3.png)

- Использованы аргументы командой строки и ручное редактирование, получился файл second.s

![compilation2](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/compilation2.png)

---
![4_4](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/4_4.png)

- Программа скомпилирована и скомпонована без опций отладки
(доделать gcc second.s -o main2)
---
![4_5](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/4_5.png)

- Сделать полное тестовое покрытие
---
![4_6](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/4_6.png)

-   Сформировать отчет, описывающий результаты тестовых прогонов и ис- пользуемых опций компиляции и/или описания проведенных модифика- ций.
---
## 5 баллов
![5_1](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/5_1.png)

- Функции с передачей данных через параметры использованы (файл main.c)

```
void getArrayA(int sizeA){  
    for (int i = 0; i < sizeA; ++i) {  
        int value;  
        printf("Enter %d value: ", i + 1);  
        scanf("%d", &value);  
        arrayA[i] = value;  
    }  
}  
  
void getArrayB(int sizeA){  
    for (int i = 0; i < sizeA; ++i) {  
        arrayB[i] = arrayA[i] * arrayA[i];  
    }  
}  
  
void outResult(int sizeA){  
    printf("Array B: ");  
    for (int i = 0; i < sizeA; ++i) {  
        printf("%d ",arrayB[i]);  
    }  
}
```

---
![5_2](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/5_2.png)

- Локальные переменные использованы(Например, value в функции getArrayA и sizeA в функции main). Это можно увидеть в файле main.c
---
```
int value;

int sizeA;
```
---
![5_3](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/5_3.png)
-   В ассемблерную программу при вызове функции добавлены комментарии, описывающие передачу фактических параметров и перенос возвращаемого результата. Это можно увидеть в файле second.s
---
![5_4](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/5_4.png)
-    В функциях для формальных параметров добавлены комментарии, описывающие связь между параметрами языка Си и регистрами (стеком). Это можно увидеть в фале second.s
---
![5_5](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/5_5.png)

- Информация добавлена в отчёт

## 6 баллов
![6_1](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/6_1.png)
---
![6_2](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/6_2.png)
---
![6_3](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/6_3.png)
---
![6_4](https://github.com/kolpakovee/avs_idz1/blob/main/criteria/6_4.png)
