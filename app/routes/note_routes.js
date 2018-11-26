function errorReq(errorStr, req) {
    const error = {error: errorStr};
    for ( key in req.body ) {
        if (!req.body[key]) {
            error[key] = req.body[key]
        }
    }
    Object.keys(error).length
    if (Object.keys(error).length > 1) return error;
}




module.exports = (app, db) => {

    app.get("/admin/selfname/:id",  (req, res) => {                   // Выборка своего имени админом

        const query1 = `SELECT name
                        FROM users_date 
                        WHERE id_user=${req.params.id}`


        db.query(query1, (err, result) => {

            if (err) return res.send({error: err.message});
            
            console.log(result, "get SELF NAME")
            res.send(result[0])          
          
        })  
    })

    app.get("/admin/users_data", (req, res) => {                   // Выборка всех имен и id пользователей 

        const query1 = `SELECT name, id_user
                        FROM users_date 
                        WHERE id_user IN (SELECT id FROM users WHERE status='user')`


        db.query(query1, (err, result) => {

            if (err) return res.send({error: err.message});
            
            console.log(result, '/admin/users_data')
            res.send(result)          
          
        }) 
    })

    app.get("/admin/usertodo/:id", (req, res) => {                   // Выборка todo одного пользователя
        console.log(req)
        query1 = `SELECT *
                  FROM todos
                  WHERE id_user='${req.params.id}'`

        db.query(query1, (err, result) => {

            if (err) return res.send({error: err.message});
            
            console.log(result, '/admin/usertodo')
            res.send(result)          
          
        }) 
    })

    
    app.post("/completed", (req, res) => {                     // Отметка о выполнении
        const error = errorReq('Некорректное значение', req)
        if (error) return res.send(error);
        
        const query1 = `UPDATE todos
                        SET todo_status=${req.body.completed}, date_complete=NOW()
                        WHERE id=${req.body.id}`
        const query2 = `SELECT *
                        FROM todos 
                        WHERE id_user=(SELECT id_user FROM todos WHERE id=${req.body.id})`

        db.query(query1, (err, result) => {
            
            if (err) return res.send({error: err.message});
            
            if (result) {
                db.query(query2, (err, result) => {

                    if (err) return res.send({error: err.message});
                    res.send(result)          
                })
            }
        }) 
    })

    app.post("/check", (req, res) => {                        // Отметка о прочтении боссом
        const error = errorReq('Некорректное значение', req)
        if (error) return res.send(error);
        
        const query1 = `UPDATE todos 
                        SET check_status=${req.body.check}, date_check=NOW()
                        WHERE id=${req.body.id}`
        const query2 = `SELECT *
                        FROM todos 
                        WHERE id_user=(SELECT id_user FROM todos WHERE id=${req.body.id})`

        db.query(query1, (err, result) => {
            
            if (err) return res.send({error: err.message});
            
            if (result) {
                db.query(query2, (err, result) => {

                    if (err) return res.send({error: err.message});
                    res.send(result)          
                })
            }
        }) 
    })

            
    app.post('/new-todo', (req, res) => {                     // Новая запись задания
        const error = errorReq('Некорректное значение', req);
        if (error) return res.send(error);
        
        const deadline = `${req.body.date} ${req.body.datetime}`
        console.log(deadline)

        const query1 = `INSERT INTO todos (id_user, todo, date, date_deadline)
                        VALUES ('${req.body.id_user}', '${req.body.todo}', NOW(), '${deadline}' )`
        const query2 = `SELECT *
                        FROM todos 
                        WHERE id_user=${req.body.id_user}`

        db.query(query1, (err, result) => {

            if (err) return res.send({error: err.message});
            
            if (result) {
                db.query(query2, (err, result) => {

                    if (err) return res.send({error: err.message});
                    res.send(result)          
                })
            }
        }) 

    })
 

    app.post('/new-user', (req, res) => {                    //добавление нового пользователя
        const error = errorReq('Некорректное значение', req)
        if (error) return res.send(error);

        const query1 = `INSERT INTO users (login, password, status)
                        VALUES ('${req.body.login}', '${req.body.password}', '${req.body.status}')`;

        const query2 = `INSERT INTO users_date (id_user, name, positions)
                        VALUES (LAST_INSERT_ID(), '${req.body.name}', '${req.body.position}')`;
        // опционально
        const query3 = `SELECT name, id_user
                        FROM users_date 
                        WHERE id_user IN (SELECT id FROM users WHERE status='user')`
        
        db.query(query1, (err, result) => {
            
            if (err) return res.send({error: err.message});
            
            if (result) {

                db.query(query2, (err, result) => {
                    if (err) return res.send({error: err.message});

                    if (result) {
                        db.query(query3, (err, result) => {
                            if (err) return res.send({error: err.message});

                            res.send(result) 
                        })
                    }
                })
                // Для целостности нужна транзакция, но пока не вышло
            }
        }) 
    })





    app.post('/auth', (req, res) => {            // Авторизация

        const query1 = `SELECT status, id
                        FROM users 
                        WHERE password='${req.body.password}' 
                        AND login='${req.body.login}'`
        

        db.query(query1, (err, result) => {

            if (err) return res.send({error: err.message});
            if (result[0] == undefined) return res.send({error: "Неверно введен логин или пароль, проверьте правильность введенных данных"});

            let query2 = '';

            const status = result[0]; // {status:, id:}
     

                query2 = `SELECT *
                          FROM todos
                          WHERE id_user='${result[0].id}'`


            db.query(query2, (err, result) => {
                if (err) return res.send({error: err.message});

                const fullResult=[...result, status]; // {todo}{todo}{status:, id:} 
                console.log(fullResult);
                res.send(fullResult);
            }) 

            // console.log('Cookies: ', req.cookies);
            // console.log('Signed Cookies: ', req.signedCookies)
        });     
    });  
    
}