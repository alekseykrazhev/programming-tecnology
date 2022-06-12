#include <sqlite3.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int callback(void *data, int argc, char **argv, char **azColName)
{
    int i;
    fprintf(stderr, "%s: ", (const char *)data);

    for (i = 0; i < argc; i++)
    {
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }

    printf("\n");
    return 0;
}

void append(char *s, char c)
{
    int len = strlen(s);
    s[len] = c;
    s[len + 1] = '\0';
}

const char *transaction = "BEGIN TRANSACTION;select * from products; insert into products values (11, 'name', price, store, 'sort', 'date', 'store_date', category_id); COMMIT;";

int main(int argc, char *argv[])
{
    sqlite3 *db;
    char *zErrMsg = 0;
    int rc;
    char *sql;
    const char *data = "Callback function called";

    rc = sqlite3_open("products", &db);

    if (rc)
    {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        return (0);
    }
    else
    {
        fprintf(stderr, "Opened database successfully\n");
    }

    int ask = -1;
    printf("%s\n", "1 - SELECT operation, 2 - INSERT operation, 3 - DELETE operation, 4 - request, 5 - exit");
    scanf("%d", &ask);

    if (ask == 1)
    {
        sql = "SELECT * FROM PRODUCT";
        rc = sqlite3_exec(db, sql, callback, (void *)data, &zErrMsg);

        if (rc != SQLITE_OK)
        {
            fprintf(stderr, "SQL error: %s\n", zErrMsg);
            sqlite3_free(zErrMsg);
        }
        else
        {
            fprintf(stdout, "Operation done successfully\n");
        }
    }

    if (ask == 2)
    {
        char name[100];
        char price[100];
        char store[100];
        char sort[100];
        char date[100];
        char store_date[100];
        char id[100];
        char category_id[100];
        printf("%s\n", "Enter id");
        scanf("%s", id);
        printf("%s\n", "Enter name");
        scanf("%s", name);
        printf("%s\n", "Enter price");
        scanf("%s", price);
        printf("%s\n", "Enter store");
        scanf("%s", store);
        printf("%s\n", "Enter sort");
        scanf("%s", sort);
        printf("%s\n", "Enter date");
        scanf("%s", date);
        printf("%s\n", "Enter store_date");
        scanf("%s", store_date);
        printf("%s\n", "Enter category_id");
        scanf("%s", category_id);
        char sq[2048] = "INSERT INTO product (id, name, price, store, sort, date, store_date, category_id) "
                        "VALUES (";
        strcat(sq, id);
        strcat(sq, ", '");
        strcat(sq, name);
        strcat(sq, "', ");
        strcat(sq, price);
        strcat(sq, ", ");
        strcat(sq, store);
        strcat(sq, ", '");
        strcat(sq, sort);
        strcat(sq, "', strftime('%Y-%m-%d', '");
        strcat(sq, date);
        strcat(sq, "'), strftime('%Y-%m-%d', '");
        strcat(sq, store_date);
        strcat(sq, "'), ");
        strcat(sq, category_id);
        strcat(sq, ");");
        printf("%s\n", sq);
        rc = sqlite3_exec(db, sq, callback, 0, &zErrMsg);

        if (rc != SQLITE_OK)
        {
            fprintf(stderr, "SQL error: %s\n", zErrMsg);
            sqlite3_free(zErrMsg);
        }
        else
        {
            fprintf(stdout, "Operation done successfully\n");
        }
    }

    if (ask == 3)
    {
        printf("%s\n", "1 - id, 2 - name");
        int ask2 = -1;
        scanf("%d", &ask2);
        if (ask2 == 1)
        {
            printf("%s", "Enter ID of product ");
            char id;
            scanf("%c", &id);
            scanf("%c", &id);
            char str[31] = "delete from product where id=";
            append(str, id);
            sql = str;
        }
        if (ask2 == 2)
        {
            printf("%s", "Enter name of product ");
            char name[100];
            scanf("%s", name);
            char str[50] = "delete from product where name like '%";
            strcat(str, name);
            strcat(str, "%';");
            sql = str;
        }
        rc = sqlite3_exec(db, sql, callback, (void *)data, &zErrMsg);

        if (rc != SQLITE_OK)
        {
            fprintf(stderr, "SQL error: %s\n", zErrMsg);
            sqlite3_free(zErrMsg);
        }
        else
        {
            fprintf(stdout, "Operation done successfully\n");
        }
    }

    if (ask == 4)
    {
        printf("%s\n", "1 - id, 2 - name, 3 - category_id");
        int ask2 = -1;
        scanf("%d", &ask2);
        sql = "SELECT * FROM PRODUCT where id = 1";
        if (ask2 == 1)
        {
            printf("%s", "Enter ID of product ");
            char id;
            scanf("%c", &id);
            scanf("%c", &id);
            char str[31] = "select * from product where id=";
            append(str, id);
            sql = str;
        }
        if (ask2 == 2)
        {
            printf("%s", "Enter name of product ");
            char name[100];
            scanf("%s", name);
            char str[50] = "select * from product where name like '%";
            strcat(str, name);
            strcat(str, "%';");
            sql = str;
        }

        if (ask2 == 3)
        {
            printf("%s", "Enter category_id of products ");
            char id;
            scanf("%c", &id);
            scanf("%c", &id);
            char str[50] = "select * from product where category_id=";
            append(str, id);
            sql = str;
        }

        rc = sqlite3_exec(db, sql, callback, (void *)data, &zErrMsg);

        if (rc != SQLITE_OK)
        {
            fprintf(stderr, "SQL error: %s\n", zErrMsg);
            sqlite3_free(zErrMsg);
        }
        else
        {
            fprintf(stdout, "Operation done successfully\n");
        }
    }

    if (ask == 5)
    {
        printf("%s\n", "Goodbye!");
        sqlite3_close(db);
        return 0;
    }

    sqlite3_close(db);
    return 0;
}
