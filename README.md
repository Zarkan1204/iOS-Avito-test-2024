# Search Media - приложение для поиска контента в медиатеке iTunes.

![main-1](https://github.com/Zarkan1204/iOS-Avito-test-2024/assets/119850620/7b9cf849-482d-4279-82ff-05d8c96e37ce)


## Roadmap 
 1. [Introduction](#1-introduction)
 2. [Features](#2-features)
 3. [Technologies](#3-technologies)
 4. [Problems & solving](#4-problems--solving)
 5. [Feedback](#5-feedback)
 6. [Preview](#6-preview)

 ### 1. Introduction
Приложение разработано в рамках тестового задания на позицию iOS trainee. Цель проекта - создание удобного приложения для поиска медиа-контента, просмотра детальной информации и его содержимого.

 ### 2. Features
- поиск контента в медиатеке iTunes;
- возможность выбора категории (movie, audiobook, song);
- возможность выбора количества результатов (30, 40, 50);
- сохранение 5 последних поисковых запросов;
- вывод подсказок при вводе запроса;
- просмотр дополнительной информации о контенте;
- возможность просмотра контента в медиатеке Apple;
- просмотр других работ автора.

 ### 3. Technologies
- Swift, стандартные библиотеки
- Архитектурный паттерн: MVVM
- Навигация: Паттерн Координатор
- Сохранение данных: UserDefaults
- Работа с сетью: URLSession

 ### 4. Problems & solving
Проблема: Структуры различных типов контента содержат как одинаковые, так и отличающиеся свойства.  
Решение: Использование опциональных значений в структуре для парсинга.
<br><br>

Проблема: Сохранение и выборка последних запросов.  
Решение: При правильном сохранении последних запросов для выборки достаточно использовать метод массива contains. Перед сохранением необходимо проверять наличие соответствующего значения в массиве с последними запросами, чтобы исключить добавление одинаковых запросов при повторном вызове пользователем.
Т.к. сохранять необходимо только 5 значений, использовался UserDefaults. Не пришлось использовать достаточно объемную библиотеку CoreData.
<br><br>


Проблема: Необходимые поля для выполнения запроса.  
Решение: Перед выполнением запроса происходят следующие проверки:
- в поле для ввода указан текст запроса;
- в разделе «entity» выбран хотя бы один параметр;
- в разделе «limit» выбран один параметр.
При невыполнении хотя бы одного условия, пользователю выводится предупреждение.
<br><br>


Проблема: Состояние приложения.  
Решение: Для того, чтобы пользователь понимал, что приложение находится в состоянии загрузки, на экране отображается ActivityIndicator.
<br><br>


Проблема: Загрузка данных при переходе на экран детальной информации.  
Решение: Экран детальной информации визуально поделен на 2 части. Информация для верхней части передается при осуществлении перехода с основного экрана, не нуждается в повторной загрузке. Дополнительная информация, связанная с другими работами автора, загружается при переходе и отображается по окончанию загрузки. В момент загрузки, в нижней части экрана пользователю показывается ActivityIndicator.
<br><br>


Проблема: Определение размера поля с описанием.  
Решение: Описание контента может быть различного размера. Необходимо определить его размер, чтобы правильно отображать коллекцию, расположенную ниже. (Label c описанием находится кастомной view). Для решения проблемы изначально использовался intrinsicContentSize и hugging priority. Проблема решилась правильным указанием констрейнтов.
<br><br>


Проблема: Отсутствие «описания» у контента из категории «song».  
Решение: При отсутствии описания у контента, изменяется верхняя привязка коллекции, расположенной ниже.
<br><br>


Проблема: Т.к. URLSession асинхронный API необходимо, чтобы изображения соответствовали контенту.  
Решение: Для синронизации контента и изображений использовалась DispatchGroup. По завершению загрузки, отображается коллекция с подготовленными данными.
<br><br>


Проблема: Необходимо осуществлять внедрение зависимостей извне, а не создание зависимости внутри объекта.  
Решение: Для внешнего внедрения зависимостей использовался DIContainer.

 ### 5. Feedback

* Герасимов Артем Игоревич
* artemtrim@mail.ru
* Zarkan1204 - Telegramm

### 6. Preview

![Preview](https://drive.google.com/file/d/1uSYszVohJ1VzRf5Svz67ah8Rq3mc8vwl/view?usp=sharing)



