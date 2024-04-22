//
//  enable_tso.h
//  learingC
//
//  Created by Rohaan on 08/02/2024.
//

#ifndef enable_tso_h
#define enable_tso_h

#include <stdio.h>

#include <errno.h>
#include <pthread.h>
#include <stdatomic.h>
#include <stddef.h>
#include <sys/sysctl.h>

typedef struct {
    void *(*function)(void *);
    void *argument;
} pthread_context;

static pthread_context context_arena[4096];

int overriden_pthread_create(pthread_t *thread, const pthread_attr_t *attr, void *(*start_routine)(void *), void *arg);

__attribute__((used, section("__DATA,__interpose"))) static struct {
    int (*overriden_pthread_create)(pthread_t *, const pthread_attr_t *, void *(*)(void *), void *);
    int (*pthread_create)(pthread_t *, const pthread_attr_t *, void *(*)(void *), void *);
} pthread_create_interpose = {overriden_pthread_create, pthread_create};

#endif /* enable_tso_h */
